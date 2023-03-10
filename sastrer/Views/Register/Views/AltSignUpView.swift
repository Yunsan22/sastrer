//
//  AltSignUpView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/9/23.
//

import SwiftUI

struct AltSignUpView: View {
    
    @StateObject private var vm = RegistrationViewModelImpl(service: RegistrationServiceImpl()
    )
    @State var appear = [ false,false,false]
    
    @EnvironmentObject var model: Model
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle).bold()
                .opacity(appear[0] ? 1 : 0)
                .offset(y:appear[0] ? 0 : 20)
            Text("Create an account")
                .font(.headline)
                .opacity(appear[1] ? 1 : 0)
                .offset(y:appear[1] ? 0 : 20)
            Group {
                TextField("Email", text: $vm.userDetails.email)
                    .inputStyle(icon: "envelope.badge.shield.half.filled.fill")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password",text: $vm.userDetails.password)
                    .inputStyle(icon: "lock.shield.fill")
                    .textContentType(.password)
                SecureField("Confirm Password",text: $vm.userDetails.confirmPassw)
                    .inputStyle(icon: "lock.shield.fill")
                    .textContentType(.password)
                
                TextField("Name", text: $vm.userDetails.firstName)
                    .inputStyle(icon: "person.crop.circle.fill")
                    .keyboardType(.namePhonePad)
                
                
                TextField("Last Name", text: $vm.userDetails.lastName)
                    .inputStyle(icon: "person.crop.circle.fill")
                    .keyboardType(.namePhonePad)
                
                
                Button {
                    
                    vm.register()
                    
                } label: {
                    Text("Verify Email and Register")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .blendMode(.overlay)
                .buttonStyle(.angular)
                .tint(.blue)
                .controlSize(.large)
                .shadow(color: Color("Shadow").opacity(0.2), radius: 30,x:0,y:30)
                .alert(isPresented: $vm.hasError) {
                    if case .failed(let error) = vm.state {
                        return Alert(title: Text("Error"), message: Text(error.localizedDescription))
                    }
                    else {
                        return Alert(title: Text("Error"),
                                     message: Text("Something went wrong"))
                    }
                }
                
                
                Text("By clicking on ") +
                Text("__Verify and Register__").foregroundColor(.primary.opacity(0.7)) +
                Text(", you agree to our **Terms of Service** and **[Privacy Policy](https://google.com)**")
                Divider()
                
                HStack {
                    Text("Already have an account?")
                    Button{
                        model.selectedModel = .signIn
                    } label: {
                        Text("**Sign in**")
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

struct AltSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        AltSignUpView()
            .environmentObject(Model())
    }
}
