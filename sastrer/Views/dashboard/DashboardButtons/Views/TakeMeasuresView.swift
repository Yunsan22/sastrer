//
//  TakeMeasuresView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct TakeMeasuresView: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    var dashorButtons: DashorButtons = dashboardButtons[0]
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(dashorButtons.buttonTittle)
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity,
                           alignment: .center)
                    .matchedGeometryEffect(id: "title\(dashorButtons.id)", in: namespace)
                Text(dashorButtons.ButtonSubtitle.uppercased())
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity,alignment: .center)
                    .matchedGeometryEffect(id: "subtitle\(dashorButtons.id)", in: namespace)
                
                
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .blur(radius: 20)
                    .matchedGeometryEffect(id: "blur\(dashorButtons.id)", in: namespace)
            )
        }
        .preferredColorScheme(.dark)
        .foregroundColor(.white)
        .background(
            Group{
                 
                Image(dashorButtons.background2)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
//                    .frame( height: 200)
                    .offset(y:-30)
                    .matchedGeometryEffect(id: "background2\(dashorButtons.id)", in: namespace)
                Image(dashorButtons.background3)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
//                    .frame(height: 150)
                    .offset(y:-50)
                    .matchedGeometryEffect(id: "background3\(dashorButtons.id)", in: namespace)
            }
            
        )
        .background(
            Image(dashorButtons.background)
                .resizable()
                .aspectRatio( contentMode: .fill)
                .matchedGeometryEffect(id: "bckgrnd\(dashorButtons.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .matchedGeometryEffect(id: "mask\(dashorButtons.id)", in: namespace)
        )
        .frame(height: 300)
      
    }
}

struct TakeMeasuresView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        TakeMeasuresView(namespace: namespace,show: .constant(true))
    }
}

