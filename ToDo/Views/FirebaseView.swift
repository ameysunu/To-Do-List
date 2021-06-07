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
    
    @State var data: [FirebaseData] = []
    @State private var hasTimeElapsed = false
    
    var body: some View {
        
        VStack{
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
            }
            if(self.data.isEmpty){
                VStack(alignment: .center){
                    Spacer()
                    if(hasTimeElapsed == false){
                        ProgressView()
                    } else {
                        Text("No data found. Upload your data and check again.")
                            .padding()
                    }
                    Spacer()
                }
            } else {
                List {
                    ForEach((self.data), id: \.self.id){ item in
                        HStack {
                            VStack(alignment: .leading){
                                Text("\(item.title)")
                                    .font(.headline)
                                Text("\(item.value)")
                                    .font(.subheadline)
                                Text("\(item.category)")
                                    .font(.subheadline)
                            }
                            .frame(height: 50)
                            Spacer()
                            Button(action: {
                                db.collection(userID!).document(item.id).delete()
                                self.presentation.wrappedValue.dismiss()
                            }){
                                Image(systemName: "trash.fill")
                            }
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        .onAppear{
            self.update.toggle()
            getDatabase()
            loadDatabase()
        }
        
    }
    func delete(at offsets: IndexSet){
        data.remove(atOffsets: offsets)
        print(offsets)
    }
    private func loadDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            hasTimeElapsed = true
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
