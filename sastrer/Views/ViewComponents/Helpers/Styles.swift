//
//  Styles.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import Foundation
import SwiftUI

struct StrokStyle: ViewModifier {
    var cornerRadius: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(colorScheme == .dark ? 0.2 : 0.3),.black.opacity(colorScheme == .dark ? 0.3 : 0.1)], startPoint: .top, endPoint: .bottom))
                .blendMode(.overlay)
        )
            
    }
}

extension View {
    func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(StrokStyle(cornerRadius: cornerRadius))
    }
}
