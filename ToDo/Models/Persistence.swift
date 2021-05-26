//
//  Persistence.swift
//  ToDo
//
//  Created by Amey Sunu on 26/05/21.
//

import CoreData

struct PersistenceController {
   static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

            for _ in 0..<10 {
                let newItem = List(context: viewContext)
                newItem.body = "Yeet"
                newItem.title = "Dance"
                newItem.category = "Business"
            }
        do{
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
        }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "ToDo")
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL.init(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
