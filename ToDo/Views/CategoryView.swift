//
//  CategoryView.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var showingSheet = false
    
    let card: Card
    var body: some View {
        //        NavigationLink(destination: ListInfo(card: Card(name: card.name, icon: card.icon))){
        Button(action: {
            showingSheet.toggle()
        }){
            ZStack {
                
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color("categorycolor"))
                
                VStack {
                    Image(systemName: card.icon).foregroundColor(.white)
                    Text(card.name)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            
            .frame(width: 175, height: 100)
        }
        .sheet(isPresented: $showingSheet) {
            ListInfo(card: Card(name: card.name, icon: card.icon)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(card: Card.init(name: "Works", icon: "wrench.fill")).previewLayout(.fixed(width: 200, height: 100))
    }
}
