//
//  View.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/17/23.
//

import SwiftUI

extension View {

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
