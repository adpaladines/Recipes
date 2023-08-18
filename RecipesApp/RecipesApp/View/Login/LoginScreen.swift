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

struct LoginScreen: View {

    @AppStorage("myArrayKey") private var arrayRawValue = "[]"
    @StateObject var loginViewModel:LoginViewModel = .init()

    var body: some View {
//        let otpButtonText = loginViewModel.showOTPField ? "Verify Code" : "Get Code"
//        let textFieldOpacity = loginViewModel.showOTPField ? 1 : 0.4

        ScrollView(.vertical, showsIndicators: false) {
            HStack(alignment: .top) {
                VStack(alignment: .center, spacing: 15) {
                    Image("app-logo")
                        .resizable()
                        .frame(width: 48, height: 48, alignment: .center)
                    Text ("Wellcome to")
                        .font (.title)
                        .fontWeight (.semibold)
                        .lineSpacing (10)
                        .padding (.top, 8)
                        .padding (.trailing, 15)
                     Text ("\nFlavor Fusion")
                        .foregroundColor (Color("primaryColor"))
                    .font (.title)
                    .fontWeight (.semibold)
                    .lineSpacing (10)
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
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
        }
        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.showError) {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
