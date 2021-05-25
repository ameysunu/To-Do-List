//
//  ListInfo.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct ListInfo: View {
    let card: Card
    var body: some View {
        VStack (alignment: .leading){
            Text(card.name)
                .font(.title)
            Spacer()
            Text("Hello World!")
        }
    }
}

struct ListInfo_Previews: PreviewProvider {
    static var previews: some View {
        ListInfo(card: Card(name: "Works", icon: "plus"))
    }
}
