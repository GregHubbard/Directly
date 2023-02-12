//
//  Employee.swift
//  Directly
//
//  Created by Greg Hubbard on 2/12/23.
//

import Foundation

struct Employee {
    let uuid: String
    let fullName: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: EmployeeType
    let contactInfo: [ContactInfo]
    
    static var example: Employee {
        return Employee(uuid: "0d8fcc12-4d0c-425c-8355-390b312b909c",
                        fullName: "Justine Mason",
                        biography: "",
                        photoUrlSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                        photoUrlLarge: "",
                        team: "Point of Sale",
                        employeeType: EmployeeType.FULL_TIME,
                        contactInfo: [ContactInfo(type: ContactInfoType.EMAIL, value: "jmason.demo@squareup.com"),
                                      ContactInfo(type: ContactInfoType.PHONE, value: "(555) 328-0123")])
    }
}

struct ContactInfo {
    let type: ContactInfoType
    let value: String
}

enum ContactInfoType {
    case PHONE
    case EMAIL
}

extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}
