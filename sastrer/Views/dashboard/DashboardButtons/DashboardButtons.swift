//
//  DashboardButtons.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/11/23.
//

import SwiftUI

//items in the due items
struct CustomerJobs: Identifiable {
    let id = UUID()
    var customerName: String
    var dueDate: String
    var itemsDue: String
    var background: String
    var background2: String //?
    
}

var itemsDueArray = [
    CustomerJobs(customerName: "joe Doe", dueDate: "02/15/2023", itemsDue: "2", background: "Rectangle_112-removebg-preview", background2: "Rectangle_111-removebg-preview"),
    CustomerJobs(customerName: "pedro Doe", dueDate: "02/18/2023", itemsDue: "1", background: "suit", background2: "Rectangle_111-removebg-preview"),
    CustomerJobs(customerName: "juan Doe", dueDate: "02/20/2023", itemsDue: "2", background: "Rectangle_113-removebg-preview", background2: ""),
    CustomerJobs(customerName: "maria pepe", dueDate: "02/25/2023", itemsDue: "2", background: "Rectangle_114-removebg-preview", background2: "Rectangle_111-removebg-preview")
]

//buttons in home screen
struct DashorButtons: Identifiable {
    let id = UUID()
    var buttonTittle: String
    var ButtonSubtitle: String
    var background: String
    var background1: String
    var background2: String
    var background3: String
    var background4: String
}

var dashboardButtons = [

    DashorButtons(buttonTittle: "Take Measures", ButtonSubtitle: "", background: "bckgrndBtn", background1: "measurement",background2: "measuring",background3: "",background4: "Rectangle_113-removebg-preview"),
    DashorButtons(buttonTittle: "New Job", ButtonSubtitle: "", background: "bckgrndBtn", background1: "measurement",background2: "sawingjob",background3: "",background4: "Rectangle_113-removebg-preview"),
    DashorButtons(buttonTittle: "Jobs Delivered", ButtonSubtitle: "", background: "bckgrndBtn", background1: "measurement",background2: "show2",background3: "", background4: "")
]

//butons to take measurements
struct MeasuresButtons: Identifiable {
    let id = UUID()
    var measuresTittle: String
    var measuresSubtitle: String
    var footer: String
    var background: String
    var background1: String
    var background2: String
    var background3: String
    var background4: String?
}
var measuresButtons = [
    //suit measures button
    MeasuresButtons(measuresTittle: "Suit jackect", measuresSubtitle: "Men's suits measures", footer: "All measurements needed for a suit*, a vest, a shirt, or a chacabana should be input here..",background: "bckgrndBtn", background1: "suit",background2: "suit2nobck",background3: "suit3nobck"),
    //vest measures button
    MeasuresButtons(measuresTittle: "Vests", measuresSubtitle: "Men's vests measures", footer: "All measurements needed for a vest should be input here..",background: "bckgrndBtn", background1: "vest3nobck",background2: "vest2nobck",background3: "vest1nobck"),
    //shirts measures button
    MeasuresButtons(measuresTittle: "Shirts", measuresSubtitle: "Men's suits measures", footer: "All measurements needed for a shirt, or a chacabana should be input here..", background: "bckgrndBtn",background1: "shirt2nobck",background2: "shirt1nobck",background3: "chashirtnobck"),
    //women jackets,blause,dress,skirt
    MeasuresButtons(measuresTittle: "Women Tops", measuresSubtitle: "Women's jackets measures", footer: "All measurements needed for a womens jackets,blause, dress and skirt should be input here..",background: "bckgrndBtn", background1: "dressnobck",background2: "blazer2nobck",background3: "skirtnobck",background4: "blausenobck"),
    //women vest
    MeasuresButtons(measuresTittle: "Vest", measuresSubtitle: "Women's vests measures", footer: "All measurements needed for a womens vests should be input here..",background: "bckgrndBtn", background1: "wvestnobck3",background2: "wvestnobck2",background3: "wvestnobck"),
    //pants
    MeasuresButtons(measuresTittle: "Pants", measuresSubtitle: "Pant's measures", footer: "All measurements needed for a pants should be input here..",background: "bckgrndBtn", background1: "pantsnobck",background2: "pantsnobck2",background3: "pantsnbck3",background4: "pantsnobck4")
    
]



struct MeasureViews: Identifiable {
    let id = UUID()
    var view1: any View
    
}

var measureVie = [
    MeasureViews(view1: ItemsDue()),
    MeasureViews(view1: theView()),
    MeasureViews(view1: HomeView())
]
