//
//  ModalView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/10/23.
//

import SwiftUI

struct ModalView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            switch model.selectedModel {
            case .signUp: AltSignUpView()
            case .signIn: AltLoginView()
            case .resetpassword: ForgotPasswordView()
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
