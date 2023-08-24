//
//  JailbreakCheckView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/23/23.
//

import SwiftUI

struct JailbreakCheckView: View {
    
    @EnvironmentObject var coordinator: MainCoordinator

    @State var isJailbroken = false
    @State private var isChecking = false
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Image(systemName: isJailbroken ? "exclamationmark.triangle.fill" : "checkmark.seal.fill")
                        .font(.system(size: 100))
                        .foregroundColor(isJailbroken ? Color.red : Color.green)
                    
                    Text(isJailbroken ? "Jailbroken Device Detected" : "Device Not Jailbroken")
                        .font(.title)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Please note that jailbreaking your device can compromise its security.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    if !isJailbroken {
                        Text("Close this app and open it again ;)")
                            .font(.title)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 24)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isChecking = true
                        // Simulate the jailbreak check
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isJailbroken = UIDevice.current.isJailBroken
//                            isJailbroken.toggle()
                            isChecking = false
                        }
                    }) {
                        Text(isChecking ? "Checking..." : "Check Jailbreak")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(isJailbroken ? Color.red : Color.green)
                            .cornerRadius(10)
                            .opacity(isChecking ? 0.7 : 1.0)
                            .disabled(isChecking)
                    }
                    
                    if isJailbroken {
                        
                        Button {
                            coordinator.goTo(.jailBreakWeb)
//                            MyViewControllerWrapper(string: "how to remove jailbreak")
                        }label: {
                            Text("Learn How to Remove Jailbreak")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Jailbreak Check", displayMode: .inline)
        }
        .navigationDestination(for: MainPath.self) { page in
            coordinator.getPage(page)
        }
    }
}

struct JailbreakCheckView_Previews: PreviewProvider {
    static var previews: some View {
        JailbreakCheckView()
            .environmentObject(MainCoordinator())
    }
}

