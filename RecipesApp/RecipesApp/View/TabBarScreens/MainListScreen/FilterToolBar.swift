//
//  FilterToolBar.swift
//  RecipesApp
//
//  Created by andres paladines on 8/20/23.
//

import SwiftUI

struct FilterToolBar: View {
    
    @StateObject var categoriesViewModel: CategoriesViewModel
    
    @Binding var typeSelected: String
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], alignment: .center, spacing: 16) {
                    ForEach(categoriesViewModel.categoriesListFiltered, id: \.self.id) { noteType in
                        ZStack {
                            VStack(spacing: 0) {
                                AsyncImage(url: URL(string: noteType.strCategoryThumb)) {
                                    image in
                                        image
                                        .resizable()
                                        .frame(height: 24)
                                } placeholder: {
                                    Image("meal-placeholder")
                                        .resizable()
                                        .frame(height: 24)
                                }
                                .frame(width: 24, height: 24, alignment: .center)
                                Text(noteType.strCategory)
                                    .font(.caption)
                                    .padding(.top, 5)
                                    .fontWeight(.semibold)
                                    .foregroundColor( (typeSelected == noteType.strCategory) ? .primary : .gray)
                                    .padding([.horizontal])
                                    
                                if (typeSelected == noteType.strCategory) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 24, height: 3)
                                        .foregroundColor(.green)
                                        .padding(.top, 1)
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                typeSelected = noteType.strCategory
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            categoriesViewModel.fetchAllCategories()
        }
    }
}

struct FilterToolBar_Previews: PreviewProvider {
    static var previews: some View {
        FilterToolBar(categoriesViewModel: CategoriesViewModel(networkManager: NetworkManager()), typeSelected: .constant("Beef"))
    }
}
