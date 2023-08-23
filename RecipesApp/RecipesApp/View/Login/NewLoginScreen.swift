//
//  NewLoginScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/22/23.
//

import SwiftUI

struct NewLoginScreen: View {
    
    @EnvironmentObject var coordinator: MainCoordinator
    
    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false
    
    @State private var username = ""
    @State private var password = ""
    
    var titleBar: String
    
    var body: some View {
        VStack {
            ExternalHeaderBarView(title: titleBar)
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 80))
                .foregroundColor(.indigo.opacity(0.1))
                .padding(.top, 64)
            VStack(spacing: 30) {
                
                CustomTextField(hint: "Username", text: $username, contentType: .username)
                
                CustomSecureField(hint: "Password", text: $password, contentType: .password)
                
                Button(action: {
                    coordinator.path.removeLast()
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.2) {
                        logStatus = true
                    }
                }) {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 50)
                
            Spacer()
        }
        .padding()
        .toolbar(.hidden)
    }
}

struct NewLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewLoginScreen(titleBar: "Login with email")
            .environmentObject(MainCoordinator())
    }
}
