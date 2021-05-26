//
//  ListInfo.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct ListInfo: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [],predicate: NSPredicate(format: "category != %@", Category.other.rawValue))
    
    var lists: FetchedResults<ToDo>
    
    let card: Card
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Spacer()
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }){
                    Image(systemName: "multiply.circle.fill")
                }
                .padding()
            }
            Text(card.name)
                .font(.title)
                .padding()
            List {
                ForEach(lists) { list in
                    Group {
                        if (list.category == card.name){
                            VStack(alignment: .leading) {
                                Text(list.title)
                                    .font(.headline)
                                Text(list.body)
                                    .font(.subheadline)
                            }
                            .frame(height: 50)
                        }
                        else {
                            EmptyView()
                        }
                    }
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
            .navigationBarHidden(true)
            .listStyle(PlainListStyle())
        }
    }
}

struct ListInfo_Previews: PreviewProvider {
    static var previews: some View {
        ListInfo(card: Card(name: "Works", icon: "plus"))
    }
}
