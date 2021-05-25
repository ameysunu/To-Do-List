//
//  ListView.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct ListView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var title: String = ""
    @State var value: String = ""
    @State private var selection = 1
    @State var expand = false
    
    
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
            }) {
                Text("Choose Category")
            }
            .padding()
            if expand {
                Picker(selection: $selection, label: Text("Zeige Deteils")) {
                    Text("Business").tag(1)
                    Text("Personal").tag(2)
                }
                
                Button(action: {
                    self.expand.toggle()
                }){
                    Text("Exit")
                }
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
