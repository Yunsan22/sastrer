//
//  inputStyle.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/10/23.
//

import SwiftUI

struct InputStyle: ViewModifier {
//    let sfSymbol: String?
    var icon: String
    
    func body(content: Content) -> some View {
        
        content
            .padding(15)
            .padding(.leading,40)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20,style: .continuous))
            .strokeStyle(cornerRadius: 20)
            .overlay(
                Image(systemName: icon )
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(.thinMaterial,in: RoundedRectangle(cornerRadius: 15,style: .continuous))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                
            )
    }
}

extension View {
    func inputStyle(icon:  String = "envelope.badge.shield.half.filled.fill") -> some View {
        modifier(InputStyle(icon: icon))
    }
}
