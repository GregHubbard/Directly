//
//  UrlConstant.swift
//  Directly
//
//  Created by Greg Hubbard on 2/14/23.
//

import Foundation

struct UrlConstant {
    static let normal = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")
    static let empty = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json")
    static let malformed = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json")
}
