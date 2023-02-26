//
//  LoginCredentials.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/15/23.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    static  var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
