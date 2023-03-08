//
//  SuitMeasuresService.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import Foundation
import Combine
//import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseFirestore

enum MeasuresKeys: String {
    
    case back
    case sleeveLength
    case fistWidth
}

protocol SuitMeasuresService {
    func createMeasures(with DetailsMeasures: SuitMeasuresDetails) -> AnyPublisher<Void, Error>
}

final class MeasuresServiceImpl: SuitMeasuresService {
    
    
    func createMeasures(with DetailsMeasures: SuitMeasuresDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            
            Future { promise in
                let FBauth = Auth.auth()
              
                let uid = FBauth.currentUser?.uid
                //                guard let uid = FBauth.user.uid else {return}
                //                if let uid = FBauth.user.uid {
                
                let values = [MeasuresKeys.back.rawValue: DetailsMeasures.manShirtsMeasurments.back,
                              MeasuresKeys.sleeveLength.rawValue: DetailsMeasures.manShirtsMeasurments.sleeveLength,
                              MeasuresKeys.fistWidth.rawValue: DetailsMeasures.manShirtsMeasurments.fistWidth
                ] as [String : Any]
                
                let db = Firestore.firestore()
                //test should be the uid at some point
               
            let CustomerRef = db
            CustomerRef
                .collection("users").document(uid!)
                .collection("customers").document()
                .setData(values, merge: true) { (error) in
                        
                        if let error = error {
                            print("error to merge data \(error.localizedDescription)")
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                        
                    }
                
                //                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
