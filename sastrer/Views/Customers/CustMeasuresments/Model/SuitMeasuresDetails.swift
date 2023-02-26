//
//  SuitMeasuresDetails.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//
import Foundation

//aditional fields will be added for the measurments
struct SuitMeasuresDetails: Identifiable {
    var id: String
    var manShirtsMeasurments: ManShirtsMeasurements
    var womanShirtsMeasurments: WomanShirtsMeasurments
    var pantsMeasurments: PantsMeasurments
    
}


extension SuitMeasuresDetails {
    struct ManShirtsMeasurements {
        var back: String
        var fistWidth: String
        var sleeveLength: String
        var elbowWidth: String
        var chestWidth: String
        var bellyWidth: String
        var neckWidth: String
        var vestsLength: String
        var length: String
        var shortSleeveLength: String
        var shortSleeveWidth: String
        var armholeLength: String//new
        var armholeWidth: String
        var backWaistLength: String //talle trasero
        var backOverAllLength: String //largo total trasero
        var armholeRoundedWidth: String //ancho de sisa redondo
        var frontLength: String //largo delantero
        var shoulderWidth: String //
        var waist: String
        var baseHips: String //base of cadera
    }
    
}
extension SuitMeasuresDetails {
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
extension SuitMeasuresDetails {
    struct PantsMeasurments {
        var waist: String
        var hips: String
        var flyFrontKnuckle: String
        var knee: String
        var trouserRoll: String
        var length: String
        var rearKnuckleLength: String
        
    }
}

extension SuitMeasuresDetails {
    static var new: SuitMeasuresDetails {
        SuitMeasuresDetails(id: "",manShirtsMeasurments: ManShirtsMeasurements(back: "", fistWidth: "", sleeveLength: "", elbowWidth: "", chestWidth: "", bellyWidth: "", neckWidth: "", vestsLength: "", length: "", shortSleeveLength: "", shortSleeveWidth: "", armholeLength: "", armholeWidth: "", backWaistLength: "", backOverAllLength: "", armholeRoundedWidth: "", frontLength: "", shoulderWidth: "", waist: "", baseHips: ""), womanShirtsMeasurments: WomanShirtsMeasurments(back: "", fistWidth: "", sleeveLength: "", elbowWidth: "", chestWidth: "", bellyWidth: "", neckWidth: "", jacketsLength: "", length: "", shortSleeveWidth: "", skirtLength: "", bustWidth: "", lowBust: "", highBust: "", dressLength: "", armholeWidth: "", bustDrop: "", bustSeparation: "", waist: "", hips: "", lengthfromCaidatoLowBust: "", midHips: ""),pantsMeasurments: PantsMeasurments(waist: "", hips: "", flyFrontKnuckle: "", knee: "", trouserRoll: "", length: "", rearKnuckleLength: ""))
    }
}

