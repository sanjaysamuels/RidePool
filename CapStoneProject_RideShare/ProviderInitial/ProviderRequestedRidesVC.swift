//
//  ProviderRequestedRidesVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-07.
//

import UIKit
import Firebase


class ProviderRequestedRidesVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var db: Firestore!
    
    var rideDetailsList = [LogsDBModel]()
    
    let uid = Auth.auth().currentUser!.uid
    let functionalConst = FunctionalConst()
    var documentID = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Requested Rides"
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RPCustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RPCustomTableViewCell")
        db = Firestore.firestore()
        functionalConst.GetItemsFromFBDB(docName: "users", uid: uid)
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        //let db = Firestore.firestore()
        db.collection("seekerRideDetails").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    for doc in snapshot.documents{
                        let obj = LogsDBModel(name: doc["seeker_name"] as! String, rideFromTo: doc["from_to"] as! String, ridePassenger: doc["num_passenger"] as! String, rideDescription: doc["ride_decrp"] as! String, rideTime: doc["dateTime"] as! String, contact: doc["seeker_contact"] as! String, uniqueId: doc["uid"] as! String)
                        self.rideDetailsList.append(obj)
                        self.documentID.append(doc.documentID)
                        //self.myList.append(doc["from_to"] as! String)
                        //print("THIIISSS", self.myList)
                    }
                }
                self.tableView.reloadData()
            } else{
                print("Error")
            }
        }
    }
}

extension ProviderRequestedRidesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PSeekerTableDetailsVC") as? PSeekerTableDetailsVC{
            vc.sName = rideDetailsList[indexPath.row].name
            vc.sTrip = rideDetailsList[indexPath.row].rideFromTo
            vc.sTime = rideDetailsList[indexPath.row].rideTime
            vc.sDesc = rideDetailsList[indexPath.row].rideDescription
            vc.seekerUID = rideDetailsList[indexPath.row].uniqueId
            vc.seekerContact = rideDetailsList[indexPath.row].contact
            vc.seekerPassagers = rideDetailsList[indexPath.row].ridePassenger
            vc.currentDocID = documentID[indexPath.row] // the document id the the row that is clicked from the seeker ride details table
            
            vc.providerName = FunctionalConst.userName
            vc.providerContact = FunctionalConst.userContact
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension ProviderRequestedRidesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RPCustomTableViewCell", for: indexPath) as! RPCustomTableViewCell
        cell.toFrom.text = rideDetailsList[indexPath.row].rideFromTo
        cell.time.text = rideDetailsList[indexPath.row].rideTime
        
        //cell.textLabel?.text = rideDetailsList[indexPath.row].rideFromTo
        return cell
    }
    
    
}
