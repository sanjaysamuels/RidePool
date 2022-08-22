//
//  FunctionalConst.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-09.
//

import Foundation
import Firebase



class FunctionalConst{
    let db = Firestore.firestore()
    static var userName = ""
    static var userContact = ""
    
    func GetItemsFromFBDB(docName: String, uid: String){
        db.collection(docName).getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    for doc in snapshot.documents{
                        if (doc["uid"] as! String == uid){
                            FunctionalConst.userName = doc["first_name"] as! String
                            FunctionalConst.userContact = doc["contact"] as! String
                            //print("THIIISSS", self.providerNames)
                        }
     
                    }
                }
            } else{
                print("Error")
            }
        }
    }
}
