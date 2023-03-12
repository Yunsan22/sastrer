//
//  LoginService.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/15/23.
//

import Foundation
import Combine
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


enum GoogleRegistrationKeys: String {
    case fullName
    case email
    case uid
    
}

protocol LoginService {
    func login(with Credentials: LoginCredentials) -> AnyPublisher<Void,Error>
    func signInWithGoogle() -> AnyPublisher<Void,Error>
}

final class LoginServiceImpl: LoginService {
    func signInWithGoogle() -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                // Create Google Sign In configuration object.
                let config = GIDConfiguration(clientID: clientID)
//                GIDSignIn.sharedInstance.configuration = config

                // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.getRootViewController) { [self] user, error in
                  guard error == nil else {
                    // ...
                      print("error here \(error!.localizedDescription)")
                      
                     return
                  }

                  guard let authentication = user?.authentication,
                    let idToken = authentication.idToken
                  else { return
                    // ...
                    //error
                  }

                  let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                 accessToken: authentication.accessToken)

                  // ...
                    Auth.auth().signIn(with: credential) { authResult, error in
                        if error != nil {
                            //there was an error
//                            self.popSimpleAlert("Alert", messeage: error?.localizedDescription ?? "There was an error")
//                            print("this is no good")
      
                        }
                        // User is signed in
                        promise(.success(()))
//                        print("whoooooo \(user.displayName)")
                            
                        if let uid = authResult?.user.uid {
                            //create the values of the dB here
                            guard  (authResult?.user) != nil else { return}
//
                            guard let email = user?.profile?.email else { return }
//
                            guard let fullName = user?.profile?.name else { return }
//                            guard let givenName = user.profile?.givenName else {  return }
                            guard  let familyName = user?.profile?.familyName else { return}
//
                            guard let profilePicUrl = user?.profile?.imageURL(withDimension: 320) else { return }
//
                            let values = [GoogleRegistrationKeys.fullName.rawValue: fullName,
                                          GoogleRegistrationKeys.email.rawValue: email,
                                          GoogleRegistrationKeys.uid.rawValue: uid]


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

                        }
                        else {
                            print("something happend")
                            promise(.failure(NSError(domain: "Invalid User Id", code: 0,userInfo: nil)))
                        }
//                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        
                        // ...
                    }
                }
                
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
   
    
    func login(with Credentials: LoginCredentials) -> AnyPublisher<Void, Error> {
        
        Deferred {
            
            Future { promise in
                
                //create clean version of the data
                let email = Credentials.email.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = Credentials.password.trimmingCharacters(in: .whitespacesAndNewlines)
                
                //Sign in the user that has veried email
                Auth
                    .auth()
                    .signIn(withEmail: email,
                            password: password) { authResult, error in
                    //              guard let strongSelf = self else { return }
                    if let err = error {
                        //couldnt sign in
                        print("error here \(err.localizedDescription)")
                        promise(.failure(err))
//                        self.popSimpleAlert("Alert", messeage: error?.localizedDescription ?? "There was an error")
        //                    self.showError(error!.localizedDescription)
                    }
                    else {
                        //go into home
//                        promise(.success(()))
                        
                        let user = authResult!.user
                        if user.isEmailVerified {
                            print("verified user logged in just fine")
                            promise(.success(()))
        //                            let vc = UIHostingController(rootView: DashboardContentView())
        //
        //
        //                    self.presentInFullScreen(vc, animated: true)
//                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        } else {
                            //email is not verified
                            print("error here user is not verified ")
                            
//                            self.popSimpleAlert("Alert", messeage: "Email is not verified")
                        }
                    }
                }
                
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    
}
