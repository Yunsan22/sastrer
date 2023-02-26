//
//  InputTextFieldView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct InputTextFieldView: View {
    
    @Binding var text: String
    let placeholder: LocalizedStringKey
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    private let textFieldLeading: CGFloat = 30
    
    
    var body: some View {
        VStack{
            TextField(placeholder,text: $text)
                .foregroundColor(.white)
//                .placeholder(placeholder, when: text.isEmpty)
                .frame(maxWidth: .infinity,
                       minHeight: 44,alignment: .center)
                .padding(.leading, sfSymbol == nil ? textFieldLeading / 2: textFieldLeading)
                .keyboardType(keyboardType)
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
                    })
        }
        .preferredColorScheme(.dark)
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            InputTextFieldView(text: .constant(""), placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                .preview(with: "Text Input with sfSymbol")
            
               
            
            InputTextFieldView(text: .constant(""), placeholder: "First Name", keyboardType: .default, sfSymbol: nil)
                .preview(with: "first name Text Input with sfSymbol")
                
        }
     
    }
}
//
//extension View {
//    func placeholder<Content: View>(
//        when shouldShow: Bool,
//        alignment: Alignment = .leading,
//        @ViewBuilder placeholder: () -> Content) -> some View {
//
//        ZStack(alignment: alignment) {
//            placeholder().opacity(shouldShow ? 1 : 0)
//            self
//        }
//    }
//}
//
//extension View {
//    func placeholder(
//        _ text: LocalizedStringKey,
//        when shouldShow: Bool,
//        alignment: Alignment = .leading) -> some View {
//
//        placeholder(when: shouldShow, alignment: alignment) { Text(text).foregroundColor(.white) }
//    }
//}

