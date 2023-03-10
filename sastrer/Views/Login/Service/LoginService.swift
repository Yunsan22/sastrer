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
                        guard let user = authResult?.user else { return }
//                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        print("whoooooo \(user.displayName)")
                        // ...
                    }
                }
                
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func signInWithGoogle()  {
       
                
               
                
      
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
                        //go into gome
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
