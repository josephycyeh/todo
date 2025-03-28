//
//  DoneApp.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import SwiftUI

@main
struct DoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
