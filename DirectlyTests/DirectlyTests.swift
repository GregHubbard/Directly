//
//  DirectlyTests.swift
//  DirectlyTests
//
//  Created by Greg Hubbard on 2/14/23.
//

import XCTest

final class DirectlyTests: XCTestCase {
    func testLoadDataFailsWithInvalidUrl() async throws {
        let vm = EmployeeViewModel()
        await vm.loadData(url: URL(string: "invalid url"))
        XCTAssertEqual(vm.state, .error)
    }
    
    func testLoadData() async throws {
        let vm = EmployeeViewModel()
        await vm.loadData(url: URL(fileURLWithPath: "/Users/greghubbard/Dev/Directly/DirectlyTests/employeeJson.json"))
        
        DispatchQueue.main.async {
            XCTAssertEqual(vm.state, .loaded)
            XCTAssertEqual(vm.employees.count, 1)
        }
    }
    
    func testLoadDataWithMalformedJson() async throws {
        let vm = EmployeeViewModel()
        await vm.loadData(url: URL(fileURLWithPath: "/Users/greghubbard/Dev/Directly/DirectlyTests/employeeJsonMalformed.json"))
        
        DispatchQueue.main.async {
            XCTAssertEqual(vm.state, .error)
            XCTAssertEqual(vm.employees.count, 0)
        }
    }

    func testConvertData() throws {
        let vm = EmployeeViewModel()
        
        let employee1 = EmployeeJSON(
            uuid: "0d8fcc12-4d0c-425c-8355-390b312b909c",
            fullName: "Justine Mason",
            phoneNumber: "5553280123",
            emailAddress: "jmason.demo@squareup.com",
            biography: "Engineer on the Point of Sale team.",
            photoUrlSmall: "image url small",
            photoUrlLarge: "image url large",
            team: "Point of Sale",
            employeeType: .fullTime)
        let employeeJSON = [employee1]
        let employees = vm.convert(employeeJSON)
        
        let expectedEmployee = Employee(
            id: UUID(uuidString: employee1.uuid)!,
            fullName: employee1.fullName,
            biography: employee1.biography,
            photoUrlSmall: employee1.photoUrlSmall,
            photoUrlLarge: employee1.photoUrlLarge,
            team: employee1.team,
            employeeType: employee1.employeeType,
            contactInfo: [
                ContactInfo(type: .email, value: "jmason.demo@squareup.com"),
                ContactInfo(type: .phone, value: "(555) 328-0123")
            ])
        
        XCTAssertEqual(employees[0], expectedEmployee)
    }
}
