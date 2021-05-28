//
//  LoginView.swift
//  ToDo
//
//  Created by Amey Sunu on 28/05/21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var errorAlert = false
    @State var loginError: String = ""
    @State var navigated = false
    
    var body: some View {
        NavigationView{
        VStack(alignment: .leading) {
            Text("Login")
                .font(.title)
                .padding()
            TextField("Email", text: $username)
                .frame(height: 20)
                .padding(10)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                .padding([.horizontal, .top], 10)
            
            SecureField("Password", text: $password)
                .frame(height: 20)
                .padding(10)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                .padding([.horizontal, .top], 10)
            
            NavigationLink(destination: RegisterView()){
                Text("Don't have an account? Create one.")
                    .padding()
            }
            
            NavigationLink(destination: ContentView(), isActive: $navigated){
            Button (action: {
                Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                    if let e = error {
                        loginError = e.localizedDescription
                        print(e.localizedDescription)
                        self.errorAlert.toggle()
                    } else {
                        print("successful!")
                        self.navigated.toggle()
                        
                        }
                    
                }
                
            }){
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            .padding()
            .alert(isPresented: $errorAlert){
                Alert(
                    title: Text("Error"),
                    message: Text(loginError),
                    dismissButton: .default(Text("Done"))
                )
            }
        }
        }.navigationBarHidden(true)
    }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
}
