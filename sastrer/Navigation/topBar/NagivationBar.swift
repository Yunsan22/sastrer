//
//  NagivationBar.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct NavigationBar: View {
    var title: LocalizedStringKey = ""
    @Binding var hasSCrolled: Bool
    @State var showSearch = false
    @State var showProfile = false
    
    
    var body: some View {
        ZStack {
            Color.clear
                .background(
                    .ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasSCrolled ? 1 : 0)
            
            Text( title)
                .animatableFont(size: hasSCrolled ? 22 : 34, weight: .bold)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading,20)
                .padding(.top,20)
                .offset(y: hasSCrolled ? -4 : 0)
            
            HStack(spacing: 16){
                Button {
                    showSearch  = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .frame(width: 36,height: 36)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14,style: .continuous))
                        .strokeStyle(cornerRadius: 14)
                }
                .sheet(isPresented: $showSearch) {
                    SearchView()
                }
                
                Button {
                    //present profile
                    showProfile = true
                } label: {
                    Image("Avatar Default")
                        .resizable()
                        .frame(width: 26,height: 26)
                        .cornerRadius(10)
                        .padding(8)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18,style: .continuous))
                        .strokeStyle(cornerRadius: 18)
                }
                .sheet(isPresented: $showProfile) {
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity,alignment: .trailing)
            .padding(.trailing,20)
            .padding(.top,20)
            .offset(y: hasSCrolled ? -4 : 0)
        }
        .frame(height: hasSCrolled ? 44: 70)
        .frame(maxHeight: .infinity,alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Items Due", hasSCrolled: .constant(false))
    }
}
