//
//  EmployeeJSON.swift
//  Directly
//
//  Created by Greg Hubbard on 2/11/23.
//

import Foundation

struct EmployeeJSON: Codable {
    let uuid: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

enum EmployeeType: String, Codable {
    case FULL_TIME = "FULL_TIME"
    case PART_TIME = "PART_TIME"
    case CONTRACTOR = "CONTRACTOR"
}

struct Response: Codable {
    let employees: [EmployeeJSON]
}
