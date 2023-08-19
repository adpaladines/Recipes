//
//  EmailLoginScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/19/23.
//

import SwiftUI

struct EmailLoginScreen: View {
    @State var email: String = ""
    @State var pass: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            CustomTextField(hint: "Type your email", text: $email)
            CustomTextField(hint: "Type your password", text: $email)
        }
        
    }
}

struct EmailLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginScreen()
    }
}
