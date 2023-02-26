//
//  InputPasswordFieldView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/12/23.
//

import SwiftUI

struct InputPasswordFieldView: View {
    
    @Binding var password: String
    let placeholder: LocalizedStringKey
//    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        VStack {
            SecureField(placeholder,text: $password)
                .foregroundColor(.white)
//                .placeholder(placeholder, when: password.isEmpty)
                .frame(maxWidth: .infinity, minHeight: 44)
                .padding(.leading,sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
                .background(
                    ZStack(alignment: .leading){
                        
                        if let systemImage = sfSymbol {
                            Image(systemName: systemImage)
                                .font(.system(size: 16,weight: .semibold))
                                .padding(.leading,5)
                                .foregroundColor(Color.white)
                        }
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .stroke(Color.white)
                    }
            )
        }
        .preferredColorScheme(.dark)
    }
}

struct InputPasswordFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputPasswordFieldView(password:.constant(""),
                               placeholder: "Password",
                               sfSymbol: "lock")
        
    }
}

