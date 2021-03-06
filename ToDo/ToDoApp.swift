//
//  ToDoApp.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI
import Firebase

@main
struct ToDoApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            LoginView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
