//
//  EmployeeRowView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/12/23.
//

import SwiftUI

struct EmployeeRowView: View {
    private let employee: Employee
    
    init(_ employee: Employee) {
        self.employee = employee
    }
    
    var body: some View {
        HStack {
            CachedImageView(urlString: employee.photoUrlSmall)
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(employee.fullName)
                    .font(.headline)
                Text(employee.team)
                    .font(.subheadline)
            }
        }
    }
}

struct EmployeeRowView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeRowView(Employee.example)
    }
}
