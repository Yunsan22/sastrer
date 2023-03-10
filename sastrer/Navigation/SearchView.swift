//
//  SearchView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/24/23.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var show = false
    @Namespace var namespace
    @State var selectedIndex = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    content
                }
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30,style: .continuous))
                .strokeStyle(cornerRadius: 30)
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 900,height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(x:-100,y:-200)
                )
            }
            .preferredColorScheme(.dark)
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
            .sheet(isPresented: $show) {
                CustomerDetailsView(namespace: namespace, shouldShowDashboard: $show, dashorButtons: dashboardButtons[selectedIndex])
                
            }
            
        }
        
    }
    
    var content: some View {
        ForEach(Array(dashboardButtons.enumerated()),id: \.offset) { index, dashItem in
            if dashItem.buttonTittle.contains(text) || text == "" {
                
                if index != 0 {
                    Divider() }
                
                Button {
                    show = true
                    selectedIndex = index
                } label: {
                    HStack(alignment: .top,spacing: 12){
                        Image(dashItem.background2)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55,height: 55)
                            .background(Color("Background"))
                            .mask(Circle())
                        VStack(alignment: .leading,spacing: 4) {
                            
                            Text(dashItem.buttonTittle)
                                .foregroundColor(.primary)
                            Text(dashItem.ButtonSubtitle)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
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
