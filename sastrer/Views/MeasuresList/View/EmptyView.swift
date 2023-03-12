//
//  EmptyView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/11/23.
//

import SwiftUI

struct EmptyView: View {
    @Binding var text: String
    @Environment(\.dismissSearch) var dismissSearch
    @ObservedObject var models = ClientViewModel()
    
    
    var body: some View {
        List {
            Group {
                Button("Clear Search") {
                    dismissSearch()
                    handleReset()
                }
                Text("Uh OH, we dont have \(text), in your database!")
                    .font(.largeTitle)
            }
        }
        
    }
    private func handleReset() {
        text = ""
        models.search()
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(text: .constant(""))
    }
}
