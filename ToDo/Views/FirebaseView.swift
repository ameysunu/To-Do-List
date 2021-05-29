//
//  FirebaseView.swift
//  ToDo
//
//  Created by Amey Sunu on 29/05/21.
//

import SwiftUI
import Firebase

struct FirebaseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State var update = false
    let db = Firestore.firestore()
    let card: Card
    let userID = Auth.auth().currentUser?.uid
    var title: String
    var value: String
    var Category: String
    
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
            
            List{
                Group {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                        Text(value)
                            .font(.subheadline)
                        Text(Category)
                            .font(.subheadline)
                        
                    }
                    .frame(height: 50)
                    
                    
                }
            }
            Button(action : {
                db.collection(userID!).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            
                        }
                    }
                }
                self.update.toggle()
            }){
                HStack {
                    Text("Get database")
                }
            }
            .padding()
        }
    }
}

struct FirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseView(card: Card(name: "Works", icon: "plus"),title: "Test", value: "Test", Category: "Generic")
    }
}
