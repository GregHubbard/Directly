//
//  Employee.swift
//  Directly
//
//  Created by Greg Hubbard on 2/12/23.
//

import Foundation

struct Employee: Identifiable, Equatable {
    let id: UUID
    let fullName: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: EmployeeType
    let contactInfo: [ContactInfo]
    
    static var example: Employee {
        return Employee(
            id: UUID(),
            fullName: "Justine Mason",
            biography: "Engineer on the Point of Sale team.",
            photoUrlSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
            photoUrlLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
            team: "Point of Sale",
            employeeType: .fullTime,
            contactInfo: [
                ContactInfo(type: .email, value: "jmason.demo@squareup.com"),
                ContactInfo(type: .phone, value: "(555) 328-0123")
            ])
    }
}

struct ContactInfo: Equatable {
    let type: ContactInfoType
    let value: String
}

enum ContactInfoType {
    case phone
    case email
}

extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}
