//
//  DashboardSearchSugestion.swift
//  sastrer
//
//  Created by Yunior Sanchez on 3/1/23.
//

import SwiftUI

struct DashboardSearchSugestion: Identifiable {
    let id = UUID()
    var text:  String
}

var suggestions = [
DashboardSearchSugestion(text: "Take Measures"),
DashboardSearchSugestion(text: "New Job"),
DashboardSearchSugestion(text: "Jobs Delivered")
]
