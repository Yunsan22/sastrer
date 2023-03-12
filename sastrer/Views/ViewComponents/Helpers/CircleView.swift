//
//  CircleView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/11/23.
//

import SwiftUI

struct CircleView: View {
    var value: CGFloat = 0.2
    @State var appear = false
    var body: some View {
        Circle()
            .trim(from: 0,to: value)
            .stroke(style: StrokeStyle(lineWidth: 4,lineCap: .round))
            .fill(.angularGradient(colors: [.purple,.pink,.purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .rotationEffect(.degrees(270))
            .onAppear{
                withAnimation(.spring().delay(0.5)) {
                    appear = true
                }
            }
            .onDisappear {
                appear =  false
            }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
