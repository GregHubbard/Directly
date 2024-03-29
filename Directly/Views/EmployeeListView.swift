//
//  EmployeeListView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/12/23.
//

import SwiftUI

struct EmployeeListView: View {
    @EnvironmentObject var vm: EmployeeViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        if vm.employees.count == 0 {
            Text("Must be a quiet day at the office 🤷🏽‍♂️")
                .padding()
            Spacer()
        } else {
            List(vm.employees) { employee in
                EmployeeRowView(employee)
            }
            .refreshable {
                await vm.loadFromInternet(url: UrlConstant.normal, context: context)
            }
        }
    }
}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView()
    }
}
