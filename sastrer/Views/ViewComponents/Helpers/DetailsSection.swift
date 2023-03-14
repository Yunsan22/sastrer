//
//  DetailsSection.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/11/23.
//

import SwiftUI

struct DashButtons: Identifiable {
    let id = UUID()
    var tittle: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var background2: String
    var logo: String
    var progress: CGFloat
}

var buttonDetails = [
    DashButtons(tittle: "Man", subtitle: " measurements for man", text: "if you continue toy will need xyz", image: "measuring", background: "bckgrndBtn", background2: "", logo: "suit 1", progress: 0.5),
    DashButtons(tittle: "Woman", subtitle: " measurements for Woman", text: "if you continue toy will need xyz", image: "measuring", background: "bckgrndBtn", background2: "", logo: "dressnobck", progress: 0.2),
    DashButtons(tittle: "Other", subtitle: " other measurements", text: "if you continue toy will need xyz", image: "measuring", background: "bckgrndBtn", background2: "", logo: "logo", progress: 0.8)

]

struct NewJobDashboardButtons: Identifiable {
    let id = UUID()
    var tittle: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var background2: String
    var logo: String
    var progress: CGFloat
}



var newJobbuttonDetails = [
    NewJobDashboardButtons(tittle: "Make Suit Jacket", subtitle: "What do you need to make?", text: "this will also Create an event to let you know when this item is due", image: "sawingjob", background: "bckgrndBtn", background2: "", logo: "suit 1", progress: 0.6),
    NewJobDashboardButtons(tittle: "Make a Man's Vest", subtitle: "What do you need to make?", text: "this will also Create an event to let you know when this item is due", image: "sawingjob", background: "bckgrndBtn", background2: "", logo: "vest3nobck", progress: 0.5),
    
    NewJobDashboardButtons(tittle: "Make a women top", subtitle: "What do you need to make? dress, blause, skirt, jackets", text: "this will also Create an event to let you know when this item is due", image: "sawingjob", background: "bckgrndBtn", background2: "", logo: "dressnobck", progress: 0.4),
    NewJobDashboardButtons(tittle: "Make a women Vest", subtitle: "Measurements for Woman", text: "Create an event to let you know when this item is due", image: "sawingjob", background: "bckgrndBtn", background2: "", logo: "wvestnobck3", progress: 0.3),
    NewJobDashboardButtons(tittle: " Make a pair of Pants", subtitle: " other measurements", text: "Create an event to let you know when this item is due", image: "sawingjob", background: "bckgrndBtn", background2: "", logo: "pantsnobck", progress: 0.8)

]
