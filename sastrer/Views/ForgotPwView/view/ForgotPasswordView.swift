//
//  ForgotPasswordView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/12/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = ForgotPasswordViewModelImpl(service: ForgotPasswordServiceImpl()
    )
    @State var appear = [ false,false,false]
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.largeTitle).bold()
                .opacity(appear[0] ? 1 : 0)
                .offset(y:appear[0] ? 0 : 20)
            Text("Need to reset your accounts's password?")
                .font(.headline)
                .opacity(appear[1] ? 1 : 0)
                .offset(y:appear[1] ? 0 : 20)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
            Group {
                TextField("Email", text: $vm.email)
                    .inputStyle(icon: "envelope.badge.shield.half.filled.fill")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                HStack {
                    //                Spacer()
                    Text("Please allow a few minutes to recieve the email")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .tint(.secondary)
                
                Button {
                    //Handle password rese action
                    vm.sendPasswordReset()
                } label: {
                    Text("Send Password Reset Link")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .blendMode(.overlay)
                .buttonStyle(.angular)
                .tint(.blue)
                .controlSize(.large)
                
                
                Divider()
                
                HStack {
                    Text("Was your Password Reset?")
                    Button{
                        model.selectedModel = .signIn
                    } label: {
                        Text("**Sign In**")
                    }
                    
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                    .tint(.secondary)
            }
            .opacity(appear[2] ? 1 : 0)
            .offset(y:appear[2] ? 0 : 20)
                
            
        }
        .preferredColorScheme(.dark)
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30,style:  .continuous))
        .strokeStyle(cornerRadius: 30)
        .shadow(color: Color("Shadow").opacity(0.2), radius: 30,x:0,y:30)
        .padding(20)
        .background(
            Image("suit 1")
                .ignoresSafeArea()
                .frame(height: 550)
                .offset(x: -80, y: -200)
        )
        .background(
            Group {
               Image("bckgrnd")
                    .ignoresSafeArea()
                
            }
        
        )
        .onAppear{
            withAnimation(.spring().delay(0.1)) {
                appear[0] = true
            }
            withAnimation(.spring().delay(0.2)) {
                appear[1] = true
            }
            withAnimation(.spring().delay(0.3)) {
                appear[2] = true
            }
            
        }
        
    }

}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(Model())
    }
}


