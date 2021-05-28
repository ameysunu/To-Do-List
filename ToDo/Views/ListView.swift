//
//  ListView.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State var title: String = ""
    @State var value: String = ""
    @State private var selection = "Generic"
    @State var expand = false
    @State var display = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $title)
                .frame(height: 20)
                .padding(10)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                .padding([.horizontal, .top], 10)
            
            TextField("Body", text: $value)
                .frame(height: 100)
                .padding(10)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                .padding([.horizontal], 10)
            
            
            Button(action: {
                self.expand.toggle()
                display = false
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                
            }) {
                Text("Choose Category")
            }
            .padding()
            if expand {
                let categories = ["Generic", "Business", "Personal"]
                Picker(selection: $selection, label: Text("Categories")) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
                Button(action: {
                    self.expand.toggle()
                    self.display.toggle()
                }){
                    Text("Done")
                }
                .padding()
            }
            
            if display {
                Text(selection)
                    .font(.title2)
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("New List"), displayMode: .inline)
        .navigationBarItems(
            leading: Button(
                action: {
                    self.presentation.wrappedValue.dismiss()
                }){
                Text("Cancel")
                    .padding()
            }, trailing: Button(
                action: {
                    let newList = ToDo(context: viewContext)
                    newList.title = title
                    newList.body = value
                    newList.category = selection
                    newList.done = false
                    do {
                        try viewContext.save()
                        print("List Saved")
                        self.presentation.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }){
                Text("Done")
                    .padding()
            })
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
