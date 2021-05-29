//
//  HomeView.swift
//  ToDo
//
//  Created by Amey Sunu on 25/05/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            VStack(alignment: .leading){
                Text("CATEGORY")
                    .font(.subheadline)
                HStack {
                    CategoryView(card: Card(name: "Business", icon: "wrench.fill"))
                    CategoryView(card: Card(name: "Personal", icon: "studentdesk"))
                }
                HStack {
                    CategoryView(card: Card(name: "Generic", icon: "staroflife"))
                    DatabaseView(card: Card(name: "Database", icon: "staroflife"))
                }

                Spacer()
                
                HStack {
                    NavigationLink(destination: ListView()){
                        Image(systemName: "plus")
                        Text("Add a List")
                }
                }
                
            }
            .navigationTitle("To-Do List")
            .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
