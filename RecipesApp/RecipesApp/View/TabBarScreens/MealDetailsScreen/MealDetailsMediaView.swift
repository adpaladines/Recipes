//
//  MealDetailsMediaView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/21/23.
//

import SwiftUI
import Kingfisher

struct MealDetailsMediaView: View {
    
    var imageUrl: String?
    var videoUrl: String?
    
    var cornerRadius: Double = 12
    @State var isLoading = true
    @State var hasError = false
    @State var isFavorite: Bool = false
    @State var placeHolderImage: String = "meal-placeholder"
    
    @ViewBuilder
    func presentPlaceHolder() -> some View {
        Image(placeHolderImage)
            .resizable()
            .scaledToFit()
            .frame(height: 146)
            .frame(maxWidth: .infinity, alignment: .center)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.3), radius: 5)
            .padding(.top)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
            if let url = URL(string: (imageUrl ?? "") ), !hasError {
                KFImage.url(url)
                    .onSuccess { r in
                        //                            print(r)
                        isLoading = false
                        hasError = false
                        //                            print("IMAGE LOAD SUCCESS")
                    }
                    .placeholder { p in
                        ZStack(alignment: .center) {
                            Image(placeHolderImage)
                                .resizable()
                                .frame(width: 48, height: 48)
                        }
                    }
                    .onFailure({ error in
                        isLoading = false
                        hasError = true
                        placeHolderImage = "no-data-found-wide"
                        //                            print("IMAGE LOAD FAIL")
                    })
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 250)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(cornerRadius)
                    .shadow(color: .black.opacity(0.3), radius: 5)
                    .padding()
            }else  {
                presentPlaceHolder()
            }
            
            YouTubeView(completeUrl: videoUrl, videoId: nil)
                .frame(width: 300, height: 250)
                .cornerRadius(8)
                .padding()
        }
        }
    }
}

struct MealDetailsMediaView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsMediaView(imageUrl: "https://www.themealdb.com/images/media/meals/1520081754.jpg")
    }
}
