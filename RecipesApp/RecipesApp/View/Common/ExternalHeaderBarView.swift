//
//  ExternalHeaderBarView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/22/23.
//

import SwiftUI

struct ExternalHeaderBarView: View {
    
    @EnvironmentObject var coordinator: MainCoordinator
    
    var title: String = ""
   
    var body: some View {
        HStack {
            Button {
                coordinator.path.removeLast()
            } label: {
                Image(systemName: "chevron.backward")
                    .padding()
                    .imageScale(.large)
                    .frame(width: 36, height: 36)
            }
            .foregroundColor(Color(uiColor: .darkGray))
            Spacer()
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
        }
    }
}

struct ExternalHeaderBarView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalHeaderBarView(title: "Login with email")
            .environmentObject(MainCoordinator())
    }
}
