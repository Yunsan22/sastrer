//
//  SearchView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/24/23.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dashboardButtons.filter{ $0.buttonTittle.contains(text) || text == ""
                }) { dashItem in
                    Text(dashItem.buttonTittle)
                }
            }
            .searchable(text: $text,placement: .navigationBarDrawer(displayMode: .always),prompt: Text("something, else, app")) {
                ForEach(suggestions) { suggestion in
                    
                    Button {
                        text = suggestion.text
                    } label: {
                        Text(suggestion.text)
                            .searchCompletion(suggestion.text)
                    }
                    
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done").bold()
                    }
                }
            }
            
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
