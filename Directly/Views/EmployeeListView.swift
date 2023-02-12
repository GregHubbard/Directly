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
                
                VStack(alignment: .leading) {
                    HStack {
                        CachedImageView(urlString: employee.photoUrlSmall)
                            .padding(.trailing, 10)
                        VStack(alignment: .leading) {
                            Text(employee.fullName)
                                .font(.headline)
                            Text(employee.team)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        EmployeeTypeView(employee.employeeType)
                    }
                }
            }
            .task {
                await loadData()
            }
            .refreshable {
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
            employees = decodedResponse.employees.sorted { $0.fullName < $1.fullName }
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
