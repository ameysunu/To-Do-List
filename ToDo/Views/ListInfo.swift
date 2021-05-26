//
//  ListInfo.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct ListInfo: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [],predicate: NSPredicate(format: "category != %@", Category.other.rawValue))
    
    var lists: FetchedResults<ToDo>
    
    let card: Card
    var body: some View {
        VStack (alignment: .leading){
            Text(card.name)
                .font(.title)
                .padding()
            List {
                ForEach(lists) { list in
                    VStack(alignment: .leading) {
                        Text(list.title)
                            .font(.headline)
                        Text(list.body)
                            .font(.subheadline)
                    }
                    .frame(height: 50)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewContext.delete(lists[index])
                    }
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            .listStyle(PlainListStyle())
        }
    }
}

struct ListInfo_Previews: PreviewProvider {
    static var previews: some View {
        ListInfo(card: Card(name: "Works", icon: "plus"))
    }
}
