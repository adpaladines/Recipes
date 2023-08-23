//
//  HeaderBar.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/20/23.
//

import SwiftUI

struct MainHeaderBar: View {
    
    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false
        
    @EnvironmentObject var coordinator: MainCoordinator
    
    @State var isAlertPresent: Bool = false
    @State var presentingModal: Bool = false
    
    var categories: [Category] = []
    var title: String = ""
    var notifications: Int = 0
    var showBackButton: Bool = false
    
    var body: some View {
        HStack {
            
            if showBackButton {
                Button {
                    coordinator.path.removeLast()
                } label: {
                    Image(systemName: "chevron.backward")
                        .padding()
                        .imageScale(.large)
                        .frame(width: 36, height: 36)
                }
                .foregroundColor(Color(uiColor: .darkGray))
            }
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
            
            Menu {
                Button {
                    presentingModal = true
                }label: {
                    HStack {
                        Image(systemName: "checkmark.square")
                        Text("Select preferred categories")
                    }
                }
                Button {
                    guard categories.isNotEmpty else  {
                        presentingModal = true
                        return
                    }
                    coordinator.goTo(.preferredCategories(categories: categories))
                }label: {
                    HStack {
                        Image(systemName: "checklist")
                            .foregroundColor(.red)
                        Text("My categories")
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                    }
                }
                Button {
                    isAlertPresent = true
                }label: {
                    HStack {
                        Image(systemName: "power")
                            .foregroundColor(.red)
                        Text("Close session")
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                    }
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color(hex: "F1F1F1", alpha: 1.0))
                        .cornerRadius(16)
                    Image("my-avatar")
                        .resizable()
                        .padding([.all], 2)
                }
                .frame(width: 64, height: 64, alignment: Alignment.center)
            }
            .menuStyle(.button)
            
        }
        .alert(isPresented: $isAlertPresent) {
            Alert(
                title: Text("My session"),
                message: Text("Do you want to close your session?"),
                primaryButton: Alert.Button.destructive(Text("Close session"),action: {
                    logStatus = false
                    if coordinator.path.count > 1 {
                        coordinator.path.removeLast()
                    }
                }),
                secondaryButton: Alert.Button.cancel(Text("Cancel")))
        }
        .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal) }
    }
}

struct MainHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderBar(title: "Hi Andres", notifications: 1)
            .environmentObject(MainCoordinator())
    }
}
