//
//  LoginViewModel.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/12/23.
//

import SwiftUI
import Firebase

//Apple Login
import AuthenticationServices

//Google Login
import GoogleSignIn
import GoogleSignInSwift


class LoginViewModel: ObservableObject {
    //MARK: View Propertiee
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""

    @Published var CLIENT_CODE: String = ""
    @Published var showOTPField: Bool = false

    //MARK: Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""


    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false
    @AppStorage(UserDefaultsKeys.preferredCategories.rawValue) private var preferredCategories = "[]"

    @Published var nouce: String = "" //For Apple Login

    func storePreferred(categories: [String]) {
        preferredCategories = categories.rawValue
    }

    //MARK: Firebase API's
    /**
     A function that deletes item from coredata.
     - Returns: returning nothing
     - Throws: throws error: Error
     - Remark: This function uses a do catch statement to obtain OTP code from phone number sent to google..
     */
    func getOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                //MARK: Disable it when testing with Real Device
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                await MainActor.run(body: {
                    CLIENT_CODE = code
                    //MARK: Enabling OTP Field when it's success
                    withAnimation(.easeInOut){showOTPField = true}
                })
            }catch let error {
                await handleError(error: error)
            }
        }
    }

    func verifyOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                let credential = PhoneAuthProvider.provider().credential(
                    withVerificationID: CLIENT_CODE,
                    verificationCode: otpCode
                )
                try await Auth.auth().signIn(with: credential)
                print(Auth.description())
                print("SUCESS!")
            }catch let error {
                await handleError(error: error)
            }
        }
    }

    //MARK: Logging Google User into Firebase

    func logGoogleUser(user: GIDGoogleUser) {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                guard let idToken = user.authentication.idToken else {return}
                let accessToken = user.authentication.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//                let credential = OAuthProvider.credential(withProviderID: idToken, accessToken: accessToken)

                try await Auth.auth().signIn(with: credential)

                print("SUCCESS Google SignIn!")
                await MainActor.run(body: {
                    withAnimation(.easeOut) { logStatus = true }
                })

            }catch let error {
                await handleError(error: error)
            }
        }
    }

    func handleError(error: Error) async {
        await MainActor.run(body: {
            print(error)
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

