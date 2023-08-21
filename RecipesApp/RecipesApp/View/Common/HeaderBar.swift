//
//  HeaderBar.swift
//  RecipesApp
//
//  Created by andres paladines on 8/20/23.
//

import SwiftUI

struct MainHeaderBar: View {
    
    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State var isAlertPresent: Bool = false
    
    var title: String = ""
    var notifications: Int = 0
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            ZStack(alignment: .topTrailing) {
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 24, height: 24)
//                    .badge(1)
                if notifications != 0 {
                    Text("\(notifications)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: -15, y: -5)
                }
            }
            
            ZStack {
                Circle()
                    .foregroundColor(Color(hex: "F1F1F1", alpha: 1.0))
                    .cornerRadius(16)
                Image("my-avatar")
                    .resizable()
                    .padding([.all], 2)
            }
            .frame(width: 64, height: 64, alignment: Alignment.center)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isAlertPresent = true
                }
            }
        }
        .alert(isPresented: $isAlertPresent) {
            Alert(
                title: Text("My session"),
                message: Text("Do you want to close your session?"),
                primaryButton: Alert.Button.destructive(Text("Close session"),action: {
                    logStatus = false
                }),
                secondaryButton: Alert.Button.cancel(Text("Cancel")))
        }
    }
}

struct MainHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderBar(title: "Hi Andres", notifications: 1)
    }
}
