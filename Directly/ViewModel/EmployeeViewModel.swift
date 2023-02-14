//
//  EmployeeViewModel.swift
//  Directly
//
//  Created by Greg Hubbard on 2/12/23.
//

import Foundation

class EmployeeViewModel: ObservableObject {
    @Published var employees = [Employee]()
    @Published var state: State
    
    init() {
        self.state = .loading
    }
    
    func loadData(url: URL?) async {
        guard let url = url else {
            self.state = .error
            print("Invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            let employeesJSON = decodedResponse.employees.sorted { $0.fullName < $1.fullName }
            DispatchQueue.main.async {
                self.employees = self.convert(employeesJSON)
                self.state = .loaded
            }
        } catch {
            DispatchQueue.main.async {
                self.state = .error
            }
            print(error)
        }
    }
    
    private func convert(_ employeesJSON: [EmployeeJSON]) -> [Employee] {
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
    
    enum State {
        case error
        case loading
        case loaded
    }
}
