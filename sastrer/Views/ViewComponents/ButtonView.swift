//
//  ButtonView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct ButtonView: View {
    
    typealias ActionHandler = () -> Void
    
    let title: LocalizedStringKey
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    
    private let cornerRadius: CGFloat = 10
    
    internal init(title: LocalizedStringKey,
                  background: Color = .blue,
                  foreground: Color = . white,
                  border: Color = .clear,
                  handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler,label: {
            Text(title)
                .frame(maxWidth: .infinity,minHeight: 44,
                       maxHeight: 50)
        })
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size:16, weight: .bold))
        .cornerRadius(cornerRadius)
        .overlay(
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(border,lineWidth: 2))
    }
}

struct ButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonView(title: "Save and Continue") { }
                
            ButtonView(title: "secondary Button",
                       background: .clear,
                       foreground: .blue,
                       border: .blue) { }
                
        }
        
    }
}
