//
//  ProviderAddRideVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-03.
//

import UIKit
import Firebase

class ProviderAddRideVC: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var allRidesBtn: UIButton!
    @IBOutlet weak var myRidesBtn: UIButton!
    @IBOutlet weak var reloadBtn: UIButton!
    
    var rideDetailsList = [LogsDBModel]()
    var providerContact = [String]()
    let currentProviderUID = Auth.auth().currentUser!.uid
    var documentID = [String]()
    
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Available Rides"
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RPCustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RPCustomTableViewCell")
        db = Firestore.firestore()
        //loadData()
        myRidesBtn.titleLabel?.textColor = .gray
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        self.rideDetailsList = []
        loadData()
        self.tableView.reloadData()
    }
    
    @IBAction func reloadPressed(_ sender: UIButton) {
        self.rideDetailsList = []
        loadData()
        self.tableView.reloadData()
    }
    @IBAction func allRidesPressed(_ sender: Any) {
        reloadBtn.isEnabled = true
        myRidesBtn.titleLabel?.textColor = .gray
        allRidesBtn.titleLabel?.textColor = .systemBlue
        self.rideDetailsList = []
        loadData()
        self.tableView.reloadData()
    }
    
    @IBAction func myRidesPressed(_ sender: Any) {
        myRidesBtn.titleLabel?.textColor = .systemBlue
        allRidesBtn.titleLabel?.textColor = .gray
        reloadBtn.isEnabled = false
        self.rideDetailsList = []
        db.collection("providerRideDetails").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    for doc in snapshot.documents{
                        if (doc["uid"] as! String == self.currentProviderUID){
                            let obj = LogsDBModel(name: doc["provider_name"] as! String, rideFromTo: doc["from_to"] as! String, ridePassenger: doc["num_passenger"] as! String, rideDescription: doc["ride_decrp"] as! String, rideTime: doc["dateTime"] as! String, contact: "provider_contact", uniqueId: doc["uid"] as! String)
                            //print(doc.documentID)
                            self.documentID.append(doc.documentID)
                            self.rideDetailsList.append(obj)
                        }
      
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
    
    
    
    func loadData(){
        //let db = Firestore.firestore()
        db.collection("providerRideDetails").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    for doc in snapshot.documents{
                        let obj = LogsDBModel(name: doc["provider_name"] as! String, rideFromTo: doc["from_to"] as! String, ridePassenger: doc["num_passenger"] as! String, rideDescription: doc["ride_decrp"] as! String, rideTime: doc["dateTime"] as! String, contact: "provider_contact", uniqueId: doc["uid"] as! String)
                        //print(doc.documentID)
                        self.documentID.append(doc.documentID)
                        self.rideDetailsList.append(obj)
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


extension ProviderAddRideVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProviderTableDetailsVC") as? ProviderTableDetailsVC{
            vc.pName = rideDetailsList[indexPath.row].name
            vc.pTrip = rideDetailsList[indexPath.row].rideFromTo
            vc.pTime = rideDetailsList[indexPath.row].rideTime
            vc.pDesc = rideDetailsList[indexPath.row].rideDescription
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProviderAddRideVC: UITableViewDataSource{
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
    
    // function to delete a table row
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Function which deletes the row both in the core data base and as well as in the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if (rideDetailsList[indexPath.row].uniqueId == currentProviderUID){
                tableView.beginUpdates()
                //let item = rideDetailsList[indexPath.row]
                rideDetailsList.remove(at: indexPath.row)
                db.collection("providerRideDetails").document(documentID[indexPath.row]).delete()
                //self.deleteItem(item: item)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            } else{
                let alert = UIAlertController(title: "Alert", message: "Sorry, you can only delete rides you created!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

        }
    }
    
    
}


