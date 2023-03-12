//
//  SessionService.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/14/23.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum SessionState {
    case loggedIn
    case loggedOut
    case loading
}

protocol SessionService {
    var state: SessionState { get }
    var userDetails: SessionUserDetails? { get }
    func logout()
}

final class SessionServiceImpl: ObservableObject, SessionService {
    
    @Published var state: SessionState = .loading
    @Published var userDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    init() {
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
//        try? Auth.auth().signOut()
    }
    
    func dismiss(){
        
        self.state = .loggedOut
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.state = .loading
        }
    }
    
    
    
}

private extension SessionServiceImpl {
    func setupFirebaseAuthHandler() {
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] res, usersdb in
                guard let self = self else { return }
                
                let currenUser = Auth.auth().currentUser
                
                //is user verified
                let isVerifiedUser = usersdb?.isEmailVerified
//                let verifiedUse =
                self.state = isVerifiedUser != true ? .loggedOut : .loggedIn
                
                if let uid = usersdb?.uid {
                    
                    
                    self.handleRefresh(with: uid)
//                    self.handlegoogleinfo()
                }
            }
    }
    
    func handleRefresh(with uid: String) {
        
        
        

        //get a reference to Database
        let db = Firestore.firestore()
        
        //ref to doc
        let loggeduserRef = db.collection("users").document(uid)
        //read the document at spefic path
            
        loggeduserRef.getDocument(completion: { snapshot, error in
            
            //check for errors
            if error == nil {
                //no error
                if let snapshot = snapshot {
                    
                          //get all the documents and customer info
                          let data = snapshot.data()
                          let fullName = data?[RegistrationKeys.fullName.rawValue] as? String
                            let email = data?[RegistrationKeys.email.rawValue] as? String
                    //update the list property in the main thread
                    DispatchQueue.main.async {
                        self.userDetails = SessionUserDetails(fullName: fullName ?? "",
                                                              email: email ?? "")
                        

                    }
                 
                    print( "the uid: \(String(describing: uid))")
                }
            } else {
                //handle error
                print("not data to displayname")
            }
            
            
        })
       
            
    }
    
    func handlegoogleinfo() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.getRootViewController) { [self] signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
 
            let user = signInResult

            let emailAddress = user.profile?.email

            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName

            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            DispatchQueue.main.async {
                self.userDetails = SessionUserDetails(fullName: fullName!,
                                                      email: emailAddress!)
                

            }
        }
    }
}
