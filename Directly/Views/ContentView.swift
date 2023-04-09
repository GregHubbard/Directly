//
//  ContentView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/9/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = EmployeeViewModel()
    @StateObject var imgCache = ImageCacheViewModel()
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationStack {
            VStack {
                switch vm.state {
                case .loading:
                    ProgressView()
                        .imageScale(.large)
                case .loaded:
                    EmployeeListView()
                case.error:
                    Text("There was an error loading data 🤔")
                        .padding()
                    Spacer()
                }
            }
            .tint(.indigo)
            .task {
                await vm.loadData(url: UrlConstant.normal, context: context)
            }
            .navigationTitle("Directly")
        }
        .environmentObject(vm)
        .environmentObject(imgCache)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
