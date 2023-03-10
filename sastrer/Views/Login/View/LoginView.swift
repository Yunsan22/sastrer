//
//  LoginView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/12/23.
//

import SwiftUI
import FirebaseAuth


struct LoginView: View {
    
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    @State private var isVerified = Auth.auth().currentUser?.isEmailVerified
    
    
    
    @StateObject private var vm = LoginViewModelImpl(
        service: LoginServiceImpl()
    )
    
    var body: some View {
        
        ZStack {

                VStack{
                    Text("Welcome")
                        .font(.system(size: 40,weight: .bold,design: .rounded))
                        .frame(maxWidth: .infinity,alignment: .center)
                        
                    Text("Login to your account")
                        .font(.footnote).foregroundColor(.secondary)
                    VStack(spacing: 16 ) {
                        InputTextFieldView(text: $vm.credentials.email , placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                        
                        InputPasswordFieldView(password: $vm.credentials.password, placeholder: "Password", sfSymbol: "lock")
                        HStack {
                            Spacer()
                            Button {
                                //handle presenting forgot password
                                showForgotPassword.toggle()
                            } label: {
                                Text("Forgot Password?")
                            }
                            .font(.system(size: 16,weight: .bold))
                            .sheet(isPresented: $showForgotPassword) {
                                ForgotPasswordView()
                            }

                        }
                        
                        ButtonView(title: "Login") {
                            //handle login
                            vm.login()
                            print("loging button not workin?")
                        }
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
                        ButtonView(title: "Register",background: .clear,foreground: .white,border: .white) {
                            //handle present sign up view
                            showRegistration.toggle()
                        }
                        .sheet(isPresented: $showRegistration) {
                            RegisterView()
                        }
                    }
                    Button {
                        //handle sign in with Google
                    } label: {
                        Text("Sign In With")
                            .foregroundColor(.white)
                        Image("Google")
                            .resizable()
                            .frame(width: 50,height: 50)
                        
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 30,style: .continuous)
                        .foregroundColor(Color("Shadow"))
                        .padding(.vertical, -30)
                )
                .frame(maxWidth: .infinity,alignment: .bottom)
                .offset(y:120)
          
        }
        
        .ignoresSafeArea()
        .background(
            Group{
                RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 900,height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(x:-100,y:-300)
                    .preferredColorScheme(.dark)
                Image("suit 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 550)
                    .offset(x: -80, y: -200)
            }
         
        )
        .preferredColorScheme(.dark)
   
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
                
        }
        
    }
}
