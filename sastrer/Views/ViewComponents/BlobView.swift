//
//  BlobView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/21/23.
//

import SwiftUI

struct BlobView: View {
    var body: some View {
        Canvas { context, size in
            context.fill(path(in: CGRect(x: 0,y: 0, width: size.width, height: size.height)), with: .linearGradient(Gradient(colors: [.pink,.blue]), startPoint: CGPoint(x:0,y:0), endPoint: CGPoint(x:400,y:400)))
            
        }
        .frame(width: 420,height: 558)
        .foregroundStyle(.linearGradient(Gradient(colors: [.pink,.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.77851*width, y: 0.56239*height))
        path.addCurve(to: CGPoint(x: 0.95358*width, y: 0.99913*height), control1: CGPoint(x: 0.77851*width, y: 0.78685*height), control2: CGPoint(x: 1.11949*width, y: 0.99913*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.50347*height), control1: CGPoint(x: 0.78768*width, y: 0.99913*height), control2: CGPoint(x: 0, y: 0.72792*height))
        path.addCurve(to: CGPoint(x: 0.47812*width, y: 0.15598*height), control1: CGPoint(x: 0, y: 0.27901*height), control2: CGPoint(x: 0.37865*width, y: 0.59792*height))
        path.addCurve(to: CGPoint(x: 0.77851*width, y: 0.56239*height), control1: CGPoint(x: 0.57759*width, y: -0.28596*height), control2: CGPoint(x: 0.77851*width, y: 0.33794*height))
        path.closeSubpath()
        return path
    }
}

struct BlobView_Previews: PreviewProvider {
    static var previews: some View {
        BlobShape()
    }
}


struct BlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.77851*width, y: 0.56239*height))
        path.addCurve(to: CGPoint(x: 0.95358*width, y: 0.99913*height), control1: CGPoint(x: 0.77851*width, y: 0.78685*height), control2: CGPoint(x: 1.11949*width, y: 0.99913*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.50347*height), control1: CGPoint(x: 0.78768*width, y: 0.99913*height), control2: CGPoint(x: 0, y: 0.72792*height))
        path.addCurve(to: CGPoint(x: 0.47812*width, y: 0.15598*height), control1: CGPoint(x: 0, y: 0.27901*height), control2: CGPoint(x: 0.37865*width, y: 0.59792*height))
        path.addCurve(to: CGPoint(x: 0.77851*width, y: 0.56239*height), control1: CGPoint(x: 0.57759*width, y: -0.28596*height), control2: CGPoint(x: 0.77851*width, y: 0.33794*height))
        path.closeSubpath()
        return path
    }
    
}
