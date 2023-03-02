//
//  CustomersMeasuresList.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/28/23.
//

import SwiftUI

struct CustomersMeasuresList: View {
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dashboardButtons.filter{ $0.buttonTittle.contains(text) || text == ""
                }) { dashItem in
                    Text(" \(dashItem.buttonTittle) \(dashItem.ButtonSubtitle)")
                }
            }
            .searchable(text: $text,placement: .navigationBarDrawer(displayMode: .always),prompt: Text("something, else, app"))
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

struct CustomersMeasuresList_Previews: PreviewProvider {
    static var previews: some View {
        CustomersMeasuresList()
    }
}
