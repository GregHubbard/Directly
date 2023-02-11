//
//  ContentView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/9/23.
//

import SwiftUI

struct Response: Codable {
    let employees: [Employee]
}

struct Employee: Codable {
    let uuid: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
//    let photoUrlSmall: String
//    let photoUrlLarge: String
    let team: String
    let employeeType: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case team
        case employeeType = "employee_type"
    }
}

enum EmployeeType: String, Codable {
    case FULL_TIME = "FULL_TIME"
    case PART_TIME = "PART_TIME"
    case CONTRACTOR = "CONTRACTOR"
}

struct ContentView: View {
    @State private var employees = [Employee]()
    
    var body: some View {
        NavigationView {
            List(employees, id: \.uuid) { employee in
                NavigationLink {
                    Text(employee.fullName)
                } label: {
                    Text(employee.fullName)
                }

            }
            .task {
                await loadData()
            }
            .navigationTitle("Directory")
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
            employees = decodedResponse.employees.sorted { $0.fullName < $1.fullName
            }
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
