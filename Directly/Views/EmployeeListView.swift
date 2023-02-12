//
//  EmployeeListView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/9/23.
//

import SwiftUI

struct EmployeeListView: View {
    @State private var employees = [Employee]()
    
    var body: some View {
        NavigationView {
            List(employees, id: \.uuid) { employee in
                DisclosureGroup {
                    ForEach(employee.contactInfo, id: \.value) { contactInfo in
                        ContactInfoView(contactInfo)
                            .padding(.leading, 50)
                    }
                } label: {
                    EmployeeRowView(employee)
                }
            }
            .tint(.indigo)
            .task {
                await loadData()
            }
            .refreshable {
                await loadData()
            }
            .navigationTitle("Directly")
        }
    }
    
    
    func loadData() async {
        guard let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json") else {
            print("Invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            let employeesJSON = decodedResponse.employees.sorted { $0.fullName < $1.fullName }
            var employees = [Employee]()
            for employeeJson in employeesJSON {
                var contactInfo = [ContactInfo]()
                contactInfo.append(ContactInfo(type: ContactInfoType.EMAIL, value: employeeJson.emailAddress))
                if let phoneNumber = employeeJson.phoneNumber {
                    contactInfo.append(ContactInfo(type: ContactInfoType.PHONE, value: phoneNumber.toPhoneNumber()))
                }
                let employee = Employee(uuid: employeeJson.uuid, fullName: employeeJson.fullName, biography: employeeJson.biography, photoUrlSmall: employeeJson.photoUrlSmall, photoUrlLarge: employeeJson.photoUrlLarge, team: employeeJson.team, employeeType: employeeJson.employeeType, contactInfo: contactInfo)
                employees.append(employee)
            }
            self.employees = employees
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView()
    }
}
