//
//  ModalView.swift
//  RecipesApp
//
//  Created by Consultant on 8/18/23.
//

import SwiftUI

struct ModalView: View {
    @Binding var presentedAsModal: Bool

    var body: some View {

            VStack {
                Text("Hello, World!")
                Button("dismiss") { self.presentedAsModal = false }
            }

    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(presentedAsModal: .constant(false))
    }
}
