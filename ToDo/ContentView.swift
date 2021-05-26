//
//  ContentView.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI
import CoreData

let persistenceController = PersistenceController.shared

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext
        )
    }
}
