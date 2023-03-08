//
//  CustomersMeasuresList.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/28/23.
//

import SwiftUI
import Firebase
import Combine


struct CustomersMeasuresList: View {
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var models = ClientViewModel()
//    @ObservableObject var viewModel = ClientViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                
                ForEach(models.clientInfo.filter{ $0.firstName.contains(text) || text == ""
                })
                { dashItem in
                    Text(dashItem.firstName)
                }
            }
            .searchable(text: $text,placement: .navigationBarDrawer(displayMode: .always),prompt: Text("something, else, app")) {
                ForEach(clientSugestion) { suggestion in
                    
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
    
    init() {
        models.getData()
    }
}

struct CustomersMeasuresList_Previews: PreviewProvider {
    static var previews: some View {
        CustomersMeasuresList()
    }
}
