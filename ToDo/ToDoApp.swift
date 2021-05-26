//
//  ToDoApp.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext
            )
        }
    }
}
