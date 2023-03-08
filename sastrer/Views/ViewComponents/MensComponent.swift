//
//  MensComponent.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct MensComponent: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    var measurementsButtons: MeasuresButtons = measuresButtons[0]
    
    var body: some View {
        
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(measurementsButtons.measuresTittle)
//                Text("aomthing")
                    .font(.largeTitle.weight(.bold))
                
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .matchedGeometryEffect(id: "title\(measurementsButtons.id)", in: namespace)
                Text(measurementsButtons.measuresSubtitle.uppercased())
                    .font(.footnote.weight(.semibold))
                    .frame(maxWidth: .infinity,alignment: .bottomLeading)
                    .foregroundColor(.secondary)
                    .matchedGeometryEffect(id: "subtitle\(measurementsButtons.id)", in: namespace)
                Text(measurementsButtons.footer)
                    .font(.footnote)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(.secondary)
                    .matchedGeometryEffect(id: "text\(measurementsButtons.id)", in: namespace)
                
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(measurementsButtons.id)", in: namespace)
            )
        }
        .preferredColorScheme(.dark)
        .foregroundColor(.white)
        .background(
            Group{
                Image(measurementsButtons.background2)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame( height: 195)
                    .offset(x:70,y:-50)
                    .matchedGeometryEffect(id: "background2\(measurementsButtons.id)", in: namespace)
                Image(measurementsButtons.background3)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(height: 195)
                    .offset(x:10,y:-50)
                    .matchedGeometryEffect(id: "background3\(measurementsButtons.id)", in: namespace)
                Image(measurementsButtons.background1)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(height: 220)
                    .offset(x:-70,y:-40)
                    .matchedGeometryEffect(id: "background\(measurementsButtons.id)", in: namespace)
                Image(measurementsButtons.background4 ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 130)
                    .offset(x:150,y:-60)
                    .matchedGeometryEffect(id: "background4\(measurementsButtons.id)", in: namespace)
                
            }
            
        )
        .background(
            Image(measurementsButtons.background)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .matchedGeometryEffect(id: "bckgrnd\(measurementsButtons.id)", in: namespace)
                .strokeStyle(cornerRadius: 30)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .matchedGeometryEffect(id: "mask\(measurementsButtons.id)", in: namespace)
        )
        .frame(height: 300)
       
    }
}

struct MensComponent_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        MensComponent(namespace: namespace,show: .constant(true))
    }
}

