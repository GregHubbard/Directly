//
//  DirectlyApp.swift
//  Directly
//
//  Created by Greg Hubbard on 2/9/23.
//

import SwiftUI

@main
struct DirectlyApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
