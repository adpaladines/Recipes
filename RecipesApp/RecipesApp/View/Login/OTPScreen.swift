//
//  OTPScreen.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/19/23.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift

struct OTPScreen: View {
    @StateObject var loginViewModel: LoginViewModel = .init()
    
    var body: some View {
        VStack {
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
        }
    }
}

struct OTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        OTPScreen()
    }
}
