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
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
