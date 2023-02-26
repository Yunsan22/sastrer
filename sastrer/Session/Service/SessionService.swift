//
//  SessionService.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/14/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth


enum SessionState {
    case loggedIn
    case loggedOut
}

protocol SessionService {
    var state: SessionState { get }
    var userDetails: SessionUserDetails? { get }
    func logout()
}

final class SessionServiceImpl: ObservableObject, SessionService {
    
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    init() {
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
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
                
                self.state = verifiedUser == true ? .loggedIn : .loggedOut
                if let uid = usersdb?.uid {
                    self.handleRefresh(with: uid)
                }
            }
    }
    
    func handleRefresh(with uid: String) {
        
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        
        ref.getDocuments { snapshot, error in
            guard  error == nil else {
                print("some erro happene in sesssion service \(error?.localizedDescription)")
                return
            }
            if let snapshot = snapshot {
                //get all domcuments and create list
                snapshot.documents.map { docu in
                    let data = docu.data()
                    
                    let firtName = data[RegistrationKeys.firstName.rawValue] as? String
                    let lastName = data[RegistrationKeys.lastName.rawValue] as? String
                    let email = data[RegistrationKeys.email.rawValue] as? String
                    
                }
            }
        }
            
    }
}
