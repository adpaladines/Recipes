//
//  EmailLoginScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/19/23.
//

import SwiftUI

struct EmailLoginScreen: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                
                Text("Login")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                CustomTextField(hint: "Username", text: $username, contentType: .username)
                    .padding()
                
                CustomTextField(hint: "Password", text: $password, contentType: .password)
                    .padding()
                
                Button(action: {
                    // Perform login logic here
                    print("Username: \(username)")
                    print("Password: \(password)")
                }) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct EmailLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginScreen()
    }
}
