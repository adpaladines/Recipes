//
//  CustomSecureField.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/12/23.
//

import SwiftUI

struct CustomSecureField: View {
    var hint: String

    @Binding var text: String
 
    @FocusState var isEnabled: Bool
    var contentType: UITextContentType = .newPassword
    var keyboardType: UIKeyboardType = .asciiCapable
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SecureField(hint, text: $text)
                .keyboardType(keyboardType)
                .textContentType(contentType)
                .focused($isEnabled)
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.green.opacity(0.2))
                Rectangle()
                    .fill(.green)
                    .frame(width: isEnabled ? nil : 0, alignment: .leading)
                    .animation(.easeInOut(duration: 0.15), value: isEnabled)
            }
            .frame(height: 2)
        }
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(hint: "1 12341413", text: .constant("12313"))
    }
}
