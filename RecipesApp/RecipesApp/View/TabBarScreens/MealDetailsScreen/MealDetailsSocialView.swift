//
//  MealDetailsSocialView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/20/23.
//

import SwiftUI

struct MealDetailsSocialView: View {
    
    var title: String
    var url: URL?
    
    @State var snapShot: Image?
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                if let url_ =  url {
                    Group {
                        ShareLink(item: url_, subject: Text("Check out this link!"), message: Text("If you want to learn how to cook this meal, take a look at this website.")) {
                            Image(systemName: "square.and.arrow.up.fill")
                                .foregroundColor(.green)
                            Text("Share")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                    }
                }
                
                
//                Group {
//                    Image(systemName: "printer.fill")
//                        .foregroundColor(.green)
//                    Text("Print")
//                        .foregroundColor(.gray)
//                }.onTapGesture {
//                    print("PRINT")
//                    snapShot = Image(uiImage: snapshot()) 
//                }
//                if let snapShot_ = snapShot {
//                    ShareLink(item: snapShot_, preview: SharePreview("Big Ben", image: snapShot_))
//                }
                
                Spacer()
            }
            .frame(height: 44)
        }
    }
}

struct MealDetailsSocialView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsSocialView(title: "Beef with salt", url: URL(string: "https://www.themealdb.com/images/media/meals/1548772327.jpg"))
    }
}
