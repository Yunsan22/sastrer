//
//  EmptyView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/11/23.
//

import SwiftUI

struct EmptyView: View {
    @Binding var text: String
    
    var body: some View {
        Text("We couldnt find: \(text)")
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(text: .constant("hahrhrhr"))
    }
}
