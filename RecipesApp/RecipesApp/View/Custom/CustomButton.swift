//
//  CustomButton.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/19/23.
//

import SwiftUI

struct CustomButton: View {
    
    @State var text: String
    @State var color: UIColor = .systemMint
    @State var disabled: Bool = false
    var cornerRadius: Double = 8
    var textColor: Color = .black
    let action: () -> Void
    
    var body: some View {
        HStack {
            ViewThatFits(in: .horizontal) {
                if disabled {
                    Button {
                        
                    } label: {
                        Text(text)
                            .foregroundColor(textColor)
                            .font(Font.system(size: 20, weight: .semibold))
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                }else {
                    Button {
                        action()
                    } label: {
                        Text(text)
                            .foregroundColor(textColor)
                            .font(Font.system(size: 20, weight: .semibold))
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                }
                
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(disabled ? .gray : Color(uiColor: color))
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white, lineWidth: 0.5)
            )
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomButton(text: "Button", color: UIColor.systemMint, action: {
            
        })
    }
}



struct WideLabel: View {
    
    @State var text: String
    
    var body: some View {
        HStack {
            ViewThatFits(in: .horizontal) {
                Text(text)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.orange)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white, lineWidth: 0.5)
            )
        }
    }
}
