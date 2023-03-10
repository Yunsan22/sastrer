//
//  Model.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/24/23.
//

import SwiftUI
import Combine

class Model : ObservableObject {
    @Published var showDetails: Bool = false
    @Published var selectedModel: Modal = .signIn
}

enum Modal: String {
    case signUp
    case signIn
    case resetpassword
}
