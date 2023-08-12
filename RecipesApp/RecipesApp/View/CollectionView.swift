//
//  CollectionView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/9/23.
//

import SwiftUI

struct CollectionView: View {
    var ids = ["CX-BdDHW0Ho", "1IszT_guI08", "lpHALkEKlDQ"]
    var body: some View {
        ZStack {
            Image("cover")
                .resizable().opacity(0.2)
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Demo")
                        .font(.title)

                    ForEach(ids, id:\.self) {idData in
                        YouTubeView(videoId: idData)
                            .frame(width: 300, height: 300)
                            .cornerRadius(8)
                            .padding()
                    }

                }
            }

        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
