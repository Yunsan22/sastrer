//
//  TailoredDataViewModel.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/4/23.
//

import Foundation
import Firebase
import FirebaseAuth

class ClientViewModel: ObservableObject {
    
    @Published var clientInfo = [ClientDataList]()
    
//    var suggested: ClientDataList = []
    
    func getData () {
        
        let uid = Auth.auth().currentUser?.uid
        
        //get a reference to Database
        let db = Firestore.firestore()
        
        //read the document at spefic path
        db.collection("/users/\(String(describing: uid!))/customers")
            .getDocuments { snapshot, error in
                //check for errors
                if error == nil {
                    //no error
                    if let snapshot = snapshot {
                        //update the list property in the main thread
                        DispatchQueue.main.async {
                            
                            //get all the documents and customer info
                            self.clientInfo = snapshot.documents.map { d in
                                
                                // create a client list for each document return
                                return ClientDataList(id: d.documentID,
                                                      firstName: d["firstName"] as? String ?? "")
                            }
                            
                        }
                        print("this is clients info \(self.clientInfo)")
                        print( "the uid: \(String(describing: uid!))")
                    }
                } else {
                    //handle error
                }
            }
    }
}
