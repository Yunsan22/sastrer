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
    @AppStorage("isLiteMode") var isLiteMode =  true
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                Section {
                    Toggle(isOn: $isLiteMode) {
                        Label("Lite Mode", systemImage: isLiteMode ? "tortoise" : "hare")
                    }
                }
//                .tint(.primary)
                
                Button{
                    //handle logout
                    confirmLogout.toggle()
                    
                } label: {
                    Text("LogOut")
                }
                
                .tint(.red)
                .alert(isPresented: $confirmLogout){
                    Alert(title: Text("Warning"),
                          message: Text("Are you sure you want to LogOut?"),
                          primaryButton: .default(Text("Yes"), action: {
                        sessionService.logout()
                        handleDismissal()
                    }),
                          secondaryButton: .cancel(Text("No")
                       
                        //
                    )
                    )
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile")
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
        .preferredColorScheme(.dark)
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
            Text("Hi \(sessionService.userDetails?.fullName ?? "N/A" )")
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text("USA")
                    .foregroundColor(.secondary)
            }
           
        }
        .frame(maxWidth: .infinity)
        

    }
    var menu: some View {
        Section {
            Label("Settings",systemImage: "gear")
            Label("Info",systemImage: "creditcard")
            Label("Help",systemImage: "questionmark")
        }
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceImpl())
    }
}

extension ProfileView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
