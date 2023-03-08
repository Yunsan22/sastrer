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
}

struct ClientSearchSugestion: Identifiable {
    let id = UUID()
    var text: String
}

var clientSugestion = [

    ClientSearchSugestion(text: "pedro")

]

