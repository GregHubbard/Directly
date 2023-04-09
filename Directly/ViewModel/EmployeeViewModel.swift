//
//  EmployeeViewModel.swift
//  Directly
//
//  Created by Greg Hubbard on 2/12/23.
//

import Foundation
import CoreData

class EmployeeViewModel: ObservableObject {
    @Published var employees = [Employee]()
    @Published var state: State
    
    init() {
        self.state = .loading
    }
    
    func saveData(context: NSManagedObjectContext, employeeJson: [EmployeeJSON]) {
        do {
            let fetchRequest = NSFetchRequest<EmployeeCore>(entityName: "EmployeeCore")
            let result = try context.fetch(fetchRequest)
            
            var isDataDifferent = false
            employeeJson.forEach { employeeJson in
                var exists = result.contains { employeeCore in employeeCore.uuid == employeeJson.uuid }
                if !exists {
                    isDataDifferent = true
                }
            }
            
            employeeJson.forEach { employeeJson in
                let employeeCore = EmployeeCore(context: context)
                employeeCore.uuid = employeeJson.uuid
                employeeCore.team = employeeJson.team
                employeeCore.photoUrlSmall = employeeJson.photoUrlSmall
                employeeCore.photoUrlLarge = employeeJson.photoUrlLarge
                employeeCore.phoneNumber = employeeJson.phoneNumber
                employeeCore.fullName = employeeJson.fullName
                employeeCore.employeeType = employeeJson.employeeType.rawValue
                employeeCore.biography = employeeJson.biography
                employeeCore.emailAddress = employeeJson.emailAddress
            }
            
            if isDataDifferent {
                try context.save()
                print("saved to core data")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromInternet(url: URL?, context: NSManagedObjectContext) async {
        guard let url = url else {
            //Invalid url
            self.state = .error
            return
        }
        
        do {
            let (data, _) = try await URLSession(configuration: .ephemeral).data(from: url)
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            let employeesJSON = decodedResponse.employees.sorted { $0.fullName < $1.fullName }
            DispatchQueue.main.async {
                print("loading data from the internet")
                self.saveData(context: context, employeeJson: employeesJSON)
                self.employees = self.convert(employeesJSON)
                self.state = .loaded
            }
        } catch {
            DispatchQueue.main.async {
                self.state = .error
            }
        }
    }
    
    func loadData(url: URL?, context: NSManagedObjectContext) async {
        
        // look how much data on disk
        
        // if there is data on disk then save
        
        // if not pull from the internet
        
        do {
            let fetchRequest = NSFetchRequest<EmployeeCore>(entityName: "EmployeeCore")
            let result = try context.fetch(fetchRequest)
            
            
            if result.count == 0 {
                await loadFromInternet(url: url, context: context)
            }
            else {
                print("loading data from disk")
                DispatchQueue.main.async {
                    self.employees = self.convert(result)
                    self.state = .loaded
                }
            }
                
        } catch {
            DispatchQueue.main.async {
                self.state = .error
            }
        }
    }
    
    internal func convert(_ employeesJSON: [EmployeeJSON]) -> [Employee] {
        var employees = [Employee]()
        for employeeJson in employeesJSON {
            let uuid = UUID(uuidString: employeeJson.uuid)!
            
            var contactInfo = [ContactInfo]()
            contactInfo.append(ContactInfo(type: .email, value: employeeJson.emailAddress))
            if let phoneNumber = employeeJson.phoneNumber {
                contactInfo.append(ContactInfo(type: .phone, value: phoneNumber.toPhoneNumber()))
            }
            
            employees.append(
                Employee(id: uuid,
                         fullName: employeeJson.fullName,
                         biography: employeeJson.biography,
                         photoUrlSmall: employeeJson.photoUrlSmall,
                         photoUrlLarge: employeeJson.photoUrlLarge,
                         team: employeeJson.team,
                         employeeType: employeeJson.employeeType,
                         contactInfo: contactInfo)
            )
        }
        
        return employees
    }
    
    internal func convert(_ employeesJSON: [EmployeeCore]) -> [Employee] {
        var employees = [Employee]()
        for employeeJson in employeesJSON {
            let uuid = UUID(uuidString: employeeJson.uuid!)!
            
            var contactInfo = [ContactInfo]()
            contactInfo.append(ContactInfo(type: .email, value: employeeJson.emailAddress!))
            if let phoneNumber = employeeJson.phoneNumber {
                contactInfo.append(ContactInfo(type: .phone, value: phoneNumber.toPhoneNumber()))
            }
            
            employees.append(
                Employee(id: uuid,
                         fullName: employeeJson.fullName!,
                         biography: employeeJson.biography,
                         photoUrlSmall: employeeJson.photoUrlSmall,
                         photoUrlLarge: employeeJson.photoUrlLarge,
                         team: employeeJson.team!,
                         employeeType: EmployeeType(rawValue: employeeJson.employeeType!)!,
                         contactInfo: contactInfo)
            )
        }
        
        return employees
    }
}
