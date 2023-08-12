//
//  LoginView.swift
//  RecipesApp
//
//  Created by Consultant on 8/11/23.
//

import SwiftUI
//Google Login
import Firebase
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {


    @StateObject var loginViewModel:LoginViewModel = .init()

    var body: some View {

//        let otpButtonText = loginViewModel.showOTPField ? "Verify Code" : "Get Code"

//        let textFieldOpacity = loginViewModel.showOTPField ? 1 : 0.4

        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: "triangle")
                    . font (.system(size: 38))
                    .foregroundColor (.indigo)

                (Text ("\nWellcome,")
                    .foregroundColor (.black) +
                 Text ("\nLogin to continue")
                    .foregroundColor (.black)
                )
                .font (.title)
                .fontWeight (.semibold)
                .lineSpacing (10)
                .padding (.top, 20)
                .padding (.trailing, 15)

                // MARK: Custom TextField
                CustomTextField(hint: "+1 1234567890", text: $loginViewModel.mobileNo)
                    .disabled(loginViewModel.showOTPField)
                    .opacity(!loginViewModel.showOTPField ? 1 : 0.4)
                    .overlay(alignment: .trailing, content: {
                        Button("Change") {
                            withAnimation(.easeOut) {
                                loginViewModel.showOTPField = false
                                loginViewModel.otpCode = ""
                                loginViewModel.CLIENT_CODE = ""
                            }
                        }
                        .font(.caption)
                        .foregroundColor(.indigo)
                        .opacity(loginViewModel.showOTPField ? 1 : 0)
                        .padding(.trailing, 16)
                    })
                    .padding(.top, 50)

                CustomTextField(hint: "OTP Code", text: $loginViewModel.otpCode)
                    .disabled(!loginViewModel.showOTPField)
                    .opacity(!loginViewModel.showOTPField ? 1 : 0.4)
                    .padding(.top, 24)

                Button(action: loginViewModel.showOTPField ? loginViewModel.verifyOTPCode : loginViewModel.getOTPCode) {
                    HStack(spacing: 16) {
                        Text(loginViewModel.showOTPField ? "Verify Code" : "Get Code")
                            .fontWeight(.semibold)
                            .contentTransition(.identity)

                        Image(systemName: "line.diagonal.arrow")
                            .font(.title3)
                            .rotationEffect(.init(degrees: 45))

                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black.opacity(0.06))
                    }
                }
                .padding(.top, 24)

                if let clientID = FirebaseApp.app()?.options.clientID {
                    GoogleSignInButton {
                        GIDSignIn.sharedInstance.signIn(with: .init(clientID: clientID), presenting: UIApplication.shared.rootController()) {user, error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            if let user = user {
                                loginViewModel.logGoogleUser(user: user)
                            }
                            //MARK: Logging Google User into Firebase
                            
                        }
                    }
                }

            }

            .padding(.leading,60)
            .padding(.vertical, 15)
        }
        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.showError) {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
