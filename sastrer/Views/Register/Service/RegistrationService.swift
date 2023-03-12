//
//  RegistrationService.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/12/23.
//

import Foundation
import Combine
import Firebase
import FirebaseStorage
import FirebaseDatabase

enum RegistrationKeys: String {
    case fullName
    case email
    case uid
    
}


protocol RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher <Void, Error>
}

final class RegistrationServiceImpl: RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error> {
        
        Deferred {
            
            Future { promise in
                
                let email = details.email
                let password = details.password.trimmingCharacters(in: .whitespacesAndNewlines)
                
                Auth.auth().createUser(withEmail: email , password: password ){ (result, error) in
                    if let err = error {
                        print(" errot to create user \(err.localizedDescription)")
                        promise(.failure(err))
                    }
                    Auth.auth().currentUser?.sendEmailVerification{ (error) in
                        if let err = error {
                            //there was an error
                            print(" erro to send verification to user \(err.localizedDescription)")
                            promise(.failure(NSError(domain: "email verification was not sent to User \(err) ", code: 0,userInfo: nil)))
                            //                                self.popSimpleAlert("Alert", messeage: "Failed to send email verification with error \(error.localizedDescription )")
                            
                        }
                       
                        if let uid = result?.user.uid {
                            
                            let values = [RegistrationKeys.fullName.rawValue:details.fullName,
                                          RegistrationKeys.email.rawValue: details.email,
                                          RegistrationKeys.uid.rawValue: uid]
                            
                            let db = Firestore.firestore()
                            
                            let  usersRef = db
                            usersRef
                                .collection("users").document(uid)
                                .setData(values) { (error) in
                                if let err = error  {
                                    print("an err to create document \(err.localizedDescription)")
                                    promise(.failure(err))
                                    //below is an alert when there is an error  creating the DB
                                    //                                        self.popSimpleAlert("Alert", messeage: "failed to saved the values \(String(describing: error?.localizedDescription))")
                                }
                                print("verification sent")
                                print("user register")
                                    promise(.success(()))
                                
                            }
                            //go back to sign in vc
//                            print("user register")
                            
                            //                                let alert = UIAlertController(title: "Alert", message: "you have registered, please verify your email", preferredStyle: .alert)
                            //                                self.present(alert,animated: true)
                            //                                let okAction = UIAlertAction(title: "OK", style: .default) {
                            //                                    (action: UIAlertAction!) in
                            //                                    self.dismiss(animated: true)
                            //                                }
                            //                                alert.addAction(okAction)
                            
                        } else {
                            print("something happend")
                            promise(.failure(NSError(domain: "Invalid User Id", code: 0,userInfo: nil)))
                        }
                        
                        
                    }
                    
                    
                    
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

//func popSimpleAlert(_ title: String, messeage: String){
//
//    let alert = UIAlertController(title: NSLocalizedString(title, comment: "comments"), message: messeage, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "comment"), style: .default))
//    present(alert,animated: true)
//}
