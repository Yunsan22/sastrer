//
//  Tab.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem( text: "Home", icon: "house",tab: .homes,color: .teal),
    TabItem(text: "Measures", icon: "lines.measurement.horizontal",tab: .measuresView,color: .blue),
    TabItem(text: "To Do", icon: "checklist.unchecked",tab: .toDoss,color: .pink),
    TabItem(text: "Calendar", icon: "calendar",tab: .calendarVi, color: .red)
]

enum Tab: String {
    case homes
    case measuresView
    case toDoss
    case calendarVi
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
        
    }
}
