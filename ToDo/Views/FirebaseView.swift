//
//  FirebaseView.swift
//  ToDo
//
//  Created by Amey Sunu on 29/05/21.
//

import SwiftUI
import Firebase

class FirebaseData: ObservableObject {
    @State var id: String
    @State var title: String
    @State var value: String
    @State var category: String
    
    init(id: String, title: String, value: String, category: String) {
        self.id = id
        self.title = title
        self.value = value
        self.category = category
    }
}

struct FirebaseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State var update = false
    
    let db = Firestore.firestore()
    let card: Card
    let userID = Auth.auth().currentUser?.uid
    
    @State var reload = false
    @State var data: [FirebaseData] = []
    
    var body: some View {
        
        VStack (alignment: .leading){
            HStack{
                Spacer()
                Button(action:{
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
                ForEach((self.data), id: \.self.id){ item in
                    Text("\(item.title)")
                    
                }
            }
            Button(action:{
                self.update.toggle()
                self.reload.toggle()
                getDatabase()
            }){
                Text("Get database")
                    .padding()
            }
        }
    }
    func getDatabase(){
        self.data.removeAll()
        self.db.collectionGroup(userID!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let id = document.documentID
                    let title = document.data()["title"] as! String
                    let value = document.data()["body"] as! String
                    let category = document.data()["category"] as! String
                    
                    self.data.append(FirebaseData(id: id, title: title, value: value, category: category))
                }
            }
        }
    }
    
}


struct FirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseView(card: Card(name: "Database", icon: "plus"))
    }
}
