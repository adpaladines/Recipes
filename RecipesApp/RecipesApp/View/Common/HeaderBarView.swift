//
//  HeaderBarView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/17/23.
//

import SwiftUI

struct HeaderBarView: View {

    @Environment(\.dismiss) private var dismiss

    @State var title: String

    var letftButtonHidden: Bool = false
    var rightButtonHidden: Bool = false

    var body: some View {
        VStack {
            HStack {
                if !letftButtonHidden {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .padding()
                            .imageScale(.large)
                            .frame(width: 36, height: 36)
                    }
                    .foregroundColor(Color(uiColor: .darkGray))
                }


                Spacer()
                Text(title)
                    .font(Font.system(size: 18, design: .default))
                    .fontWeight(.bold)
                    .lineLimit(1)
                Spacer()
                if !rightButtonHidden {
                    Button {

                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 36, height: 8)
                    }
                    .foregroundColor(Color(uiColor: .darkGray))
                }
            }
            Divider()
        }
        .padding([.horizontal])

    }
}

struct HeaderBarView_Previews: PreviewProvider {

    static var previews: some View {
        HeaderBarView(title: "My Cart")
    }
}
