//
//  CustomersMeasurementsAndDetails.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import Foundation

//this should show all the customer information and measurments
    //aditional fields will be added for the measurments
struct CustomersMeasurementsAndDetails: Identifiable {
    var id: String
    var clientInfo: ClientInfo
    var address: Address
    var manShirtsMeasurments: ManShirtsMeasurements
    var womanShirtsMeasurments: WomanShirtsMeasurments
    var pantsMeasurments: PantsMeasurments
//    var back: String
//    var fistWidth: String
//    var sleeveLength: String
//    var elbowWidth: String
//    var chestWidth: String
//    var bellyWidth: String
//    var neckWidth: String
//    var jacketsLength: String
//    var length: String
//    var shortSleeveWidth: String
//    var womenBack: String
//    var womenFistWidth: String
//    var womenSleeveLength: String
//    var womenElbowWidth: String
//    var womenChestWidth: String
//    var womenBellyWidth: String
//    var womenNeckWidth: String
//    var womenJacketsLength: String
//    var womenLength: String
//    var womenShortSleeveWidth: String
//    var skirtLength: String
//    var bustWidth: String
//    var lowBust: String
//    var highBust: String
//    var dressLength: String
//    var armholeWidth: String
//    var bustDrop: String
//    var bustSeparation: String
//    var waist: String
//    var hips: String
//    var lengthfromCaidatoLowBust: String
//    var midHips: String
//    var pantLength: String
}
extension CustomersMeasurementsAndDetails {
    struct ClientInfo {
        var firstName: String
        var lastName: String
        var gender: Gender
//        var pronoun: Pronouns
        var phone: String
        var bodyType: String
        var comments: String
    }
}
extension CustomersMeasurementsAndDetails.ClientInfo {
    enum Gender: String, Identifiable, CaseIterable {
        var id: Self { self}
        case male
        case female
        case intersex
        case transgender
        case genderneutral = "Gender neutral"
        case nonbinary = "non-binary"
        case agender
        case pangender
        case genderqueer
        case twospirit = "two-spirit"
        case na = "Prefer not to say"
    }
}
extension CustomersMeasurementsAndDetails {
    struct Address {
        var streetAddress: String
        var city: String
        var stateProvidence: String
        var postalCode: String
        var country: String
    }
}


//extension CustomersMeasurementsAndDetails.ClientInfo {
//    enum Pronouns: String, Identifiable, CaseIterable {
//        var id: Self { self}
//        case ime = "(I,me)"
//        case you = "(you)"
//        case she = "(she,her,hers)"
//        case he = "(he,him,his)"
//        case they = "(they,them,theirs)"
//        case ze = "ze,hir,hirs"
//        case na = "Prefer not to say"
//    }
//}

extension CustomersMeasurementsAndDetails {
    struct ManShirtsMeasurements {
        var back: String
        var fistWidth: String
        var sleeveLength: String
        var elbowWidth: String
        var chestWidth: String
        var bellyWidth: String
        var neckWidth: String
        var jacketsLength: String
        var length: String
        var shortSleeveWidth: String
    }
    
}
extension CustomersMeasurementsAndDetails {
    struct WomanShirtsMeasurments {
        var back: String
        var fistWidth: String
        var sleeveLength: String
        var elbowWidth: String
        var chestWidth: String
        var bellyWidth: String
        var neckWidth: String
        var jacketsLength: String
        var length: String
        var shortSleeveWidth: String
        var skirtLength: String
        var bustWidth: String
        var lowBust: String
        var highBust: String
        var dressLength: String
        var armholeWidth: String
        var bustDrop: String
        var bustSeparation: String
        var waist: String
        var hips: String
        var lengthfromCaidatoLowBust: String
        var midHips: String
    }
    
}
extension CustomersMeasurementsAndDetails {
    struct PantsMeasurments {
        var length: String
    }
}

extension CustomersMeasurementsAndDetails {
    static var new: CustomersMeasurementsAndDetails {
        CustomersMeasurementsAndDetails(id: "",
                                        clientInfo: ClientInfo(firstName: "", lastName: "",
                                                               gender: ClientInfo.Gender.allCases.first!,
                                                               phone: "", bodyType: "", comments: ""), address: Address(streetAddress: "", city: "", stateProvidence: "", postalCode: "", country: ""),manShirtsMeasurments: ManShirtsMeasurements(back: "", fistWidth: "", sleeveLength: "", elbowWidth: "", chestWidth: "", bellyWidth: "", neckWidth: "", jacketsLength: "", length: "", shortSleeveWidth: ""), womanShirtsMeasurments: WomanShirtsMeasurments(back: "", fistWidth: "", sleeveLength: "", elbowWidth: "", chestWidth: "", bellyWidth: "", neckWidth: "", jacketsLength: "", length: "", shortSleeveWidth: "", skirtLength: "", bustWidth: "", lowBust: "", highBust: "", dressLength: "", armholeWidth: "", bustDrop: "", bustSeparation: "", waist: "", hips: "", lengthfromCaidatoLowBust: "", midHips: ""),pantsMeasurments: PantsMeasurments(length: ""))
    }
}


