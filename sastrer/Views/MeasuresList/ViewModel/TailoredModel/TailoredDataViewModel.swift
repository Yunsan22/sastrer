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
    
//    @Published var contats: [String: [ClientDataList]]

    init() {
        getData()
    }
    
    func getData () {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //get a reference to Database
        let db = Firestore.firestore()
        
        //read the document at spefic path
        db.collection("/users/\(uid)/customers")
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
                                return ClientDataList( id: d.documentID,
                                                      fullName: d["firstName"] as? String ?? "",
                                                      comments: d["comments"] as? String ?? "",
                                                      gender: d["gender"] as? String ?? "",
                                                      lasName: d["lasName"] as? String ?? "",
                                                      phone: d["phone"] as? String ?? "")
                                
                            }
                            
                        }
                        
                        print( "the uid: \(uid)")
                    }
                    
                } else {
                    //handle error
                }
                print("this is clients info \(self.clientInfo)")
            }
    }
    
    func search(with text: String = "") {
        clientInfo = text.isEmpty ? clientInfo : clientInfo.filter { $0.fullName.contains(text)}
    }
}
