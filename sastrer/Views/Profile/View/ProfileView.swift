//
//  ProfileView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    @State var confirmLogout: Bool = false
    
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile")
        }
    }

    var profile: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue,.blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(Image(systemName: "hexagon")
                    .symbolVariant(.fill)
                    .foregroundColor(.blue)
                    .font(.system(size: 200))
                    .offset(x: -50,y: -100)
                )
            Text("Yunior Sanchez")
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text("USA")
                    .foregroundColor(.secondary)
            }
            Button{
                //handle logout
                confirmLogout.toggle()
                
            } label: {
                Text("LogOut")
            }
            .alert(isPresented: $confirmLogout){
                Alert(title: Text("Warning"),
                      message: Text("Are you sure you want to LogOut?"),
                      primaryButton: .default(Text("Yes"), action: {
                    sessionService.logout()
                }),
                      secondaryButton: .cancel(Text("No")
                   
                    //                    handleDismissal()
                )
                )
            }
        }
        .frame(maxWidth: .infinity)
        

    }
    var menu: some View {
        Section {
            Label("Settings",systemImage: "gear")
            Label("Billing",systemImage: "creditcard")
            Label("Help",systemImage: "questionmark")
        }
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
