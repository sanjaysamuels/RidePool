//
//  ProviderLogsVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-08.
//

import UIKit
import Firebase

class ProviderLogsVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    var db: Firestore!
    
    var logsDetailsList = [LogsDBModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Logs"
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RPCustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RPCustomTableViewCell")
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
        //loadData()
    }
    
    override func viewDidAppear(_ animated: Bool){
        logsDetailsList = []
        loadData()
    }
    
    func loadData(){
        //let db = Firestore.firestore()
        let providerUID = Auth.auth().currentUser!.uid
        db.collection("providerLogs").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    for doc in snapshot.documents{
                        if (providerUID == doc["providerUID"] as! String){
                            let obj = LogsDBModel(name: doc["seekerName"] as! String, rideFromTo: doc["trip"] as! String, ridePassenger: doc["tripPassengers"] as! String, rideDescription: doc["tripDesc"] as! String, rideTime: doc["time"] as! String, contact: doc["seekerContact"] as! String, uniqueId: doc["seekerUID"] as! String)
                            self.logsDetailsList.append(obj)
                        }
           
                        //self.rideDetailsList.append(obj)
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


extension ProviderLogsVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProviderLogsTableDetailsVC") as? ProviderLogsTableDetailsVC{
            //vc.seekerNameLabel = seekerNames[indexPath.row]
            vc.sName = logsDetailsList[indexPath.row].name
            vc.sTrip = logsDetailsList[indexPath.row].rideFromTo
            vc.sTime = logsDetailsList[indexPath.row].rideTime
            vc.sDesc = logsDetailsList[indexPath.row].rideDescription
            vc.seekerContact = logsDetailsList[indexPath.row].contact
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension ProviderLogsVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logsDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RPCustomTableViewCell", for: indexPath) as! RPCustomTableViewCell
        cell.toFrom.text = logsDetailsList[indexPath.row].rideFromTo
        cell.time.text = logsDetailsList[indexPath.row].rideTime
        
        //cell.textLabel?.text = rideDetailsList[indexPath.row].rideFromTo
        return cell
    }
    
    
}
