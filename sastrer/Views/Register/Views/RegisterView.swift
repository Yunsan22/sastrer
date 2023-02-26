//
//  RegisterView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/12/23.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var vm = RegistrationViewModelImpl(service: RegistrationServiceImpl()
    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                
                Text("Create an account")
                
                VStack(spacing: 16){
                    
                    InputTextFieldView(text: $vm.userDetails.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       sfSymbol: "envelope")
                    
                    InputPasswordFieldView(password: $vm.userDetails.password,
                                           placeholder: "Password",
                                           sfSymbol: "lock")
                    InputPasswordFieldView(password: $vm.userDetails.confirmPassw,
                                           placeholder: "Confirm Password",
                                           sfSymbol: "lock")
                    Divider()
                    InputTextFieldView(text: $vm.userDetails.firstName,
                                       placeholder: "First Name",
                                       keyboardType: .namePhonePad,
                                       sfSymbol: nil)
                    
                    InputTextFieldView(text: $vm.userDetails.lastName ,
                                       placeholder: "Last Name",
                                       keyboardType: .namePhonePad,
                                       sfSymbol: nil)
                    
                    
                }
                
                ButtonView(title: "Verify Email and Register") {
                    vm.register()
                    handleDismissal()
                    
                }
                .alert(isPresented: $vm.hasError) {
                    if case .failed(let error) = vm.state {
                        return Alert(title: Text("Error"), message: Text(error.localizedDescription))
                    }
                    else {
                        return Alert(title: Text("Error"),
                        message: Text("Something went wrong"))
                    }
                }
                ButtonView(title: "Already have an account? Sing in",background: .clear) {
                    handleDismissal()
                }
                
                
            }
            .padding(.horizontal,15)
            .navigationTitle("Register")
            .preferredColorScheme(.dark)
            .applyClose()
            .background(
                RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 900,height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(x:-100,y:-300)
            )
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

extension RegisterView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
