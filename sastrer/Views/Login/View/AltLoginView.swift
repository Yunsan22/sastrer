//
//  AltLoginView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/9/23.
//

import SwiftUI
import FirebaseAuth


struct AltLoginView: View {
    
    @StateObject private var vm = LoginViewModelImpl(
        service: LoginServiceImpl()
    )
//    @State private var showForgotPassword = false this is not longer needed
    @State private var isVerified = Auth.auth().currentUser?.isEmailVerified
    @State var appear = [ false,false,false]
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle).bold()
                .opacity(appear[0] ? 1 : 0)
                .offset(y:appear[0] ? 0 : 20)
            Text("Login to your account")
                .font(.headline)
                .opacity(appear[1] ? 1 : 0)
                .offset(y:appear[1] ? 0 : 20)
            Group {
                TextField("Email", text: $vm.credentials.email)
                    .inputStyle(icon: "envelope.badge.shield.half.filled.fill")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password",text: $vm.credentials.password)
                    .inputStyle(icon: "lock.shield.fill")
                    .textContentType(.password)
                
                HStack {
                    Spacer()
                    Button {
                        //handle presenting forgot password
                        model.selectedModel = .resetpassword
                        //                    showForgotPassword.toggle()
                    } label: {
                        Text("Forgot Password?")
                    }
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .tint(.secondary)
                    //                .font(.system(size: 16,weight: .bold))
                    //                .sheet(isPresented: $showForgotPassword) {
                    //                    ForgotPasswordView()
                    //                } this is no longer needed bc im using a modalview to go from one view ot the next
                    
                }
                
                Button {
                    vm.login()
                } label: {
                    Text("Login")
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
                    } else if isVerified == false {
                        return Alert(title: Text("Error"), message: Text("your account if not verified"))
                    }
                    else {
                        return Alert(title: Text("Error"),
                                     message: Text("Something went wrong"))
                    }
                }
                
                
                Divider()
                
                HStack {
                    Text("Do not have an account yet?")
                    Button{
                        model.selectedModel = .signUp
                    } label: {
                        Text("**Sign Up**")
                    }
                    
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .tint(.secondary)
                
                Button {
                    vm.signInWithGoogle()
                } label: {
                    HStack {
                        Image("Google")
                            .padding(.vertical,5)
                            .padding(.horizontal,20)
//                            .background(Color.white)
                        Text("Login with Google")
                            .frame(maxWidth: .infinity)
                    }
                    
//
                }
                .font(.headline)
                .blendMode(.overlay)
                .buttonStyle(.angular)
                .tint(.blue)
                .controlSize(.regular)
                .shadow(color: Color("Shadow").opacity(0.2), radius: 30,x:0,y:30)
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

struct AltLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AltLoginView()
            .environmentObject(Model())
    }
}
