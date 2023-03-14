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
    @Binding var text: String
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var model: Model
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch
    @ObservedObject var models = ClientViewModel()

    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(models.clientInfo.filter{(self.text.isEmpty ? true : $0.fullName.localizedCaseInsensitiveContains(self.text) || text == "" )}) {
                dashItem in
                    NavigationLink {
                        //TODO: here will have the details view showing measuremens and customer info
                        Text("LastName: \(dashItem.lasName)" ) //this is added for testing
                        Text("This view will present all the customer information and measurments")
                    } label: {
                        Text(dashItem.fullName) //display full name 
                    }
                    
                }

            }
            .preferredColorScheme(.dark)
            .searchable(text: $text,placement: .navigationBarDrawer(displayMode: .always),prompt: Text("Find a customer"))
            {
                
                ForEach(models.clientInfo,id: \.id) { suggestion in
                    HStack {
                        Text(suggestion.fullName)
                            .searchCompletion(suggestion.fullName)
                    }

                    
                }

            }
            .refreshable {
                models.getData()
            }
            .onSubmit(of: .search, {
                models.search(with: text)
            })
            .onAppear {
                models.search()
            }
            .onChange(of: text) { newValue in
                models.search(with: newValue)
            }
            //overlay with suggested no find
            .overlay {
                if isSearching && models.clientInfo.isEmpty {
                    EmptyView(text: $text)
                }
            }
            .navigationTitle("Measures")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    //do not know if this will be needed
                }
            }
            
        }
    }
    
    private func handleReset() {
        text = ""
        models.search()
    }
//    init() {
//        models.getData()
//    }
}

struct CustomersMeasuresList_Previews: PreviewProvider {
    static var previews: some View {
        CustomersMeasuresList(text: .constant("pepe"))
            .environmentObject(ClientViewModel())
            
    }
}
