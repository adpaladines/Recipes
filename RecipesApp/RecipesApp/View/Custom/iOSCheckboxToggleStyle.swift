//
//  iOSCheckboxToggleStyle.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/22/23.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}
