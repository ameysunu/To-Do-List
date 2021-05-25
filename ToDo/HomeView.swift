//
//  HomeView.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("CATEGORY")
                    .font(.subheadline)
                HStack {
                    CategoryView(card: Card(name: "Business", icon: "wrench.fill"))
                    CategoryView(card: Card(name: "Personal", icon: "studentdesk"))
                }
                Spacer()
                
                HStack {
                    Button(action: {
                        
                    }){
                        Image(systemName: "plus")
                        Text("Add a List")
                    }
                }
                
            }
            .navigationTitle("To-Do List")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
