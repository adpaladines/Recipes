//
//  SectionHeader.swift
//  TheSoundsStore
//
//  Created by Andres D. Paladines on 7/17/23.
//

import SwiftUI

struct SectionHeader: View {

    var leftText: String
    var rightText: String

    var body: some View {
        HStack {
            Text(leftText)
                .fontWeight(.bold)
            Spacer()
            Text(rightText)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .padding([.horizontal])
    }
}
