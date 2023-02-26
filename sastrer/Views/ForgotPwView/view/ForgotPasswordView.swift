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
    
    
    var body: some View {
        //        Color.black
        
           
            VStack(spacing: 16){
                Section {
                    
                    InputTextFieldView(text: $vm.email, placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                    
                    
                    ButtonView(title: "Send Password Reset",background: .clear,
                               foreground: .blue,
                               border: .blue) {
                        //Handle password rese action
                        vm.sendPasswordReset()
                        presentationMode.wrappedValue.dismiss()
                    }
                } header: {
                    Text("ResetPassword").font(.system(.title).weight(.bold))
                }
                .offset(y:-150)
                
            }
            .preferredColorScheme(.dark)
//            .navigationTitle(NSLocalizedString("Reset Password", comment: ""))
            .background(
                
                    RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 900,height: 400)
                        .rotationEffect(.degrees(135))
                        .offset(y:-365)
                    
                )
            .applyClose()
       
        
        
        
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}


