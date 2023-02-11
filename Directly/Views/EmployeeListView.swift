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
                
                NavigationLink {
                    VStack {
                        CachedImageView(urlString: employee.photoUrlLarge, size: 100)
                        Text(employee.fullName)
                    }
                } label: {
                    HStack {
                        CachedImageView(urlString: employee.photoUrlSmall, size: 60)
                            .padding(.trailing, 10)
                        
                        Text(employee.fullName)
                    }
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
