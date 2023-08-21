//
//  HeaderBarView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/17/23.
//

import SwiftUI

struct MealDetailsHeaderView: View {

    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coordinator: MainCoordinator

    @State var title: String

    var letftButtonHidden: Bool = false
    var rightButtonHidden: Bool = false
    
    @State var isFavorite: Bool = false
    @State var isAlertPresent: Bool = false

    var body: some View {
        VStack {
            HStack {
                if !letftButtonHidden {
                    Button {
                        coordinator.path.removeLast()
//                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .padding()
                            .imageScale(.large)
                            .frame(width: 36, height: 36)
                    }
                    .foregroundColor(Color(uiColor: .darkGray))
                }
                Spacer()
                if !rightButtonHidden {
                    Button {
                        withAnimation(.easeInOut) {
                            isAlertPresent = true
                            isFavorite.toggle()
                            //TODO: Add to CoreData
                        }
                    } label: {
                        Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .frame(width: 24, height: 30)
                            .foregroundColor(isFavorite ? .red : .gray)
                    }
                    .foregroundColor(Color(uiColor: .darkGray))
                    .frame(width: 36, height: 48)
                }
            }
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
            
        }
        .padding([.horizontal])
        .alert(isPresented: $isAlertPresent) {
            Alert(
                title: Text("Bookmark"),
                message: Text(isFavorite ? "Added to your favorites." : "Deleted from your favorites."),
                dismissButton: Alert.Button.default(Text("Ok"))
            )
        }
    }
}

struct HeaderBarView_Previews: PreviewProvider {

    static var previews: some View {
        MealDetailsHeaderView(title: "Beef with salt", isFavorite: true)
            .environmentObject(MainCoordinator())
    }
}
