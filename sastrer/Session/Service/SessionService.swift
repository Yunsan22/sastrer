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
        try? Auth.auth().signOut()
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
                //is user verified
                let verifiedUser = usersdb?.isEmailVerified
                
                self.state = verifiedUser != true ? .loggedOut : .loggedIn
                if let uid = usersdb?.uid {
                    self.handleRefresh(with: uid)
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
                          let firstName = data?[RegistrationKeys.firstName.rawValue] as? String
                          let lastName = data?[RegistrationKeys.lastName.rawValue] as? String
                            let email = data?[RegistrationKeys.email.rawValue] as? String
                    //update the list property in the main thread
                    DispatchQueue.main.async {
                        self.userDetails = SessionUserDetails(firstName: firstName!,
                                                              lastName: lastName!,
                                                              email: email!)
                        

                    }
                 
                    print( "the uid: \(String(describing: uid))")
                }
            } else {
                //handle error
            }
            
            
        })
       
            
    }
}
