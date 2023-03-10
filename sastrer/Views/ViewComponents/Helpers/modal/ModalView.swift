//
//  ModalView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/10/23.
//

import SwiftUI

struct ModalView: View {
    
    @EnvironmentObject var model: Model
    
    @State var viewState: CGSize = .zero
    
    @State var appear = [ false,false,false]
    
    var body: some View {
        ZStack {
            Group {
                switch model.selectedModel {
                case .signUp: AltSignUpView()
                case .signIn: AltLoginView()
                case .resetpassword: ForgotPasswordView()
                }
            }
            .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
            .offset(x: viewState.width, y:  viewState.height )
            .rotationEffect(.degrees(viewState.width/40))
            .rotation3DEffect(.degrees(viewState.height/20), axis: (x: 1  , y: 0, z: 0))
            .hueRotation(.degrees(viewState.width / 5 ))
            .gesture(drag)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 30,x:0,y:30)
            .opacity(appear[0] ? 1 : 0)
            .offset(y:appear[0] ? 0 : 200)
            .padding(20)
            .background(
                Image("suit 1")
                    .ignoresSafeArea()
                    .frame(height: 550)
                    .offset(x: -80, y: -200)
                    .opacity(appear[2] ? 1 : 0)
                    .offset(y:appear[2] ? 0 : 10)
                    .blur(radius: appear[2] ? 0 : 40)
                    .allowsHitTesting(false)
            )
            .background(
                Group {
                   Image("bckgrnd")
                        .ignoresSafeArea()
                    
                }
            
            )
            
        }
        .onAppear{
            withAnimation(.easeOut) {
                appear[0] = true
            }
            withAnimation(.easeOut.delay(0.1)) {
                appear[1] = true
            }
            withAnimation(.easeOut(duration: 1).delay(0.2)) {
                appear[2] = true
            }
            
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                viewState = value.translation
            }
            .onEnded { value in
                withAnimation(.openCard) {
                    viewState = .zero
                }
            }
        
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
            .environmentObject(Model())
    }
}
