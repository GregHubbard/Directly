//
//  EmployeeDetailView.swift
//  Directly
//
//  Created by Greg Hubbard on 3/8/23.
//

import SwiftUI

struct EmployeeDetailView: View {
    @EnvironmentObject var imgCache: ImageCacheViewModel
    let employee: Employee
    
    var body: some View {
        VStack {
            CachedImageView(urlString: employee.photoUrlLarge, imageCache: imgCache, size: 100)
            
            HStack {
                Text(employee.fullName)
                    .font(.largeTitle)
                
                EmployeeTypeBadge(employee.employeeType)
            }
            
            
            Form {
                Section(header: Text("About Me")) {
                    HStack {
                        Image(systemName: "person.2.circle")
                            .imageScale(.large)
                            .foregroundColor(.indigo)
                        
                        Text(employee.team)
                            .font(.caption)
                    }
                    
                    if (employee.biography != nil) {
                        HStack {
                            Image(systemName: "text.bubble")
                                .imageScale(.large)
                                .foregroundColor(.indigo)
                            
                            Text(employee.biography!)
                                .font(.caption)
                        }
                    }
                }
                
                Section(header: Text("Contact Info")) {
                    ForEach(employee.contactInfo, id: \.value) { contactInfo in
                        ContactInfoView(contactInfo)
                    }
                }
            }
        }
    }
}

struct EmployeeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDetailView(employee: Employee.example)
    }
}
