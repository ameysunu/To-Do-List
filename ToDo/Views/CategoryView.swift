//
//  CategoryView.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct CategoryView: View {
    let card: Card
    var body: some View {
        NavigationLink(destination: ListInfo(card: Card(name: card.name, icon: card.icon))){
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
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(card: Card.init(name: "Works", icon: "wrench.fill")).previewLayout(.fixed(width: 200, height: 100))
    }
}
