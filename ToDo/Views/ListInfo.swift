//
//  ListInfo.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI
import Firebase

struct ListInfo: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State var done: Bool = false
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [],predicate: NSPredicate(format: "category != %@", Category.other.rawValue))
    
    var lists: FetchedResults<ToDo>
    let db = Firestore.firestore()
    let card: Card
    let userID = Auth.auth().currentUser?.uid
    @State var upload: Bool = false
    
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
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(list.title)
                                        .font(.headline)
                                    Text(list.body)
                                        .font(.subheadline)
                                }
                                .frame(height: 50)
                                Spacer()
                                if (list.done == false) {
                                    Button(action: {
                                        list.done = true
                                    }) {
                                        Image(systemName: "circle")
                                    }
                                } else {
                                    Button(action: {
                                        list.done = false
                                    }){
                                        Image(systemName: "checkmark.circle")
                                    }
                                }
                            }
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
            
            Button(action: {
                for list in lists{
                    db.collection(userID!).addDocument(data: [
                        "title" : list.title,
                        "body" : list.body,
                        "category" : list.category
                    ])
                }
                self.upload.toggle()
            }){
                HStack {
                    Image(systemName: upload ? "checkmark" : "icloud.and.arrow.up" )
                    Text(upload ? "Done uploading!" : "Upload to Firebase" )
                }
            }
            .padding()
        }
        
    }
}

struct ListInfo_Previews: PreviewProvider {
    static var previews: some View {
        ListInfo(card: Card(name: "Works", icon: "plus"))
    }
}
