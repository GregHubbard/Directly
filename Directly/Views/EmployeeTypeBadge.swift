//
//  EmployeeTypeBadge.swift
//  Directly
//
//  Created by Greg Hubbard on 3/8/23.
//

import SwiftUI

struct EmployeeTypeBadge: View {
    private let employeeType: EmployeeType
    private var color: Color
    private var abbreviation: String
    
    init(_ employeeType: EmployeeType) {
        self.employeeType = employeeType
        
        switch employeeType {
        case EmployeeType.fullTime:
            color = .cyan
            abbreviation = "FT"
        case EmployeeType.partTime:
            color = .indigo
            abbreviation = "PT"
        case EmployeeType.contractor:
            color = .green
            abbreviation = "CN"
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color.gradient)
                .frame(width: 30)
            Text(abbreviation)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct EmployeeTypeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            EmployeeTypeBadge(EmployeeType.fullTime)
            EmployeeTypeBadge(EmployeeType.partTime)
            EmployeeTypeBadge(EmployeeType.contractor)
        }
    }
}
