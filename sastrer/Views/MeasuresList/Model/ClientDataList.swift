//
//  ClientDataList.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/4/23.
//

import Foundation

struct ClientDataList: Identifiable {
    
    var id: String
    var firstName: String
    var comments: String
    var gender: String
    var lasName: String
    var phone: String
    //need to add all measurements fields to be retrived
}

struct ClientSearchSugestion: Identifiable {
    let id = UUID()
    var text: String
}



var clientSugestion = [

    ClientSearchSugestion(text: "pedro")

]

