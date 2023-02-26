//
//  ItemsDue.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct ItemsDue: View {
    
    var itemsdue: CustomerJobs = itemsDueArray[0]
    
    @Namespace var namespace
//    var customersJobs: CustomerJobs = customersJobs[0]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8.0) {
           Spacer()
            Text(itemsdue.customerName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .lineLimit(1)
            Text("Due by \(itemsdue.dueDate)".uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text("Items due are \(itemsdue.itemsDue) Shirt, 1 pair of pants..")
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundColor(.secondary)
        }
        .preferredColorScheme(.dark)
        .padding(.all,20.0)
        .padding(.vertical,20.0)
        .frame(height: 350.0)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
        .strokeStyle()
        .padding(.horizontal,20)
        
     
    }
}

struct ItemsDue_Previews: PreviewProvider {
    static var previews: some View {
        ItemsDue()
    }
}
