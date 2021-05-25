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
    
    var body: some View {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
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
