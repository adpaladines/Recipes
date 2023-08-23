//
//  CommonHeaderBar.swift
//  RecipesApp
//
//  Created by andres paladines on 8/23/23.
//

import SwiftUI

struct CommonHeaderBar: View {
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

struct CommonHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        CommonHeaderBar(title: "Hi Andres")
            .environmentObject(MainCoordinator())
    }
}
