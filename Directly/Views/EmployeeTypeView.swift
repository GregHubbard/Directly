//
//  EmployeeTypeView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/11/23.
//

import SwiftUI

struct EmployeeTypeView: View {
    private let employeeType: EmployeeType
    private var color: Color
    private var abbreviation: String
    
    init(_ employeeType: EmployeeType) {
        self.employeeType = employeeType
        
        switch employeeType {
        case EmployeeType.FULL_TIME:
            color = .cyan
            abbreviation = "FT"
        case EmployeeType.PART_TIME:
            color = .indigo
            abbreviation = "PT"
        case EmployeeType.CONTRACTOR:
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

struct EmployeeTypeView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            EmployeeTypeView(EmployeeType.FULL_TIME)
            EmployeeTypeView(EmployeeType.PART_TIME)
            EmployeeTypeView(EmployeeType.CONTRACTOR)
        }
    }
}
