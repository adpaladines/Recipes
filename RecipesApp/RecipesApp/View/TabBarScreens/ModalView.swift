//
//  ModalView.swift
//  RecipesApp
//
//  Created by Consultant on 8/18/23.
//

import SwiftUI

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    @AppStorage(UserDefaultsKeys.notShowAgainPreferredCategoriesPupop.rawValue) private var notShowAgain = false
    
    var body: some View {

            VStack {
                Text("Hello, World!")
                Button("dismiss") {
                    self.presentedAsModal = false
                }
                Button("Do not show again") {
                    notShowAgain = true
                }
            }

    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(presentedAsModal: .constant(false))
    }
}
