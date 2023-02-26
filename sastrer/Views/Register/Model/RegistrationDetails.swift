//
//  RegistrationDetails.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/12/23.
//

import Foundation

struct RegistrationDetails {
    var email: String
    var password: String
    var confirmPassw: String
    var firstName: String
    var lastName: String
    var uid: String
}

extension RegistrationDetails {
    
    static var new: RegistrationDetails {
        
        RegistrationDetails(email: "",
                            password: "",
                            confirmPassw: "",
                            firstName: "",
                            lastName: "",
                            uid: "")
    }
}
