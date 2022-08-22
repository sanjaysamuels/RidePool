//
//  PSeekerTableDetailsVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-07.
//

import UIKit
import Firebase

class PSeekerTableDetailsVC: UIViewController {
    
    @IBOutlet weak var seekerNameLabel: UILabel!
    @IBOutlet weak var seekerTripLabel: UILabel!
    @IBOutlet weak var seekerTripTimeLabel: UILabel!
    @IBOutlet weak var seekerTripDescLabel: UILabel!
    
    var sName = ""
    var sTrip = ""
    var sTime = ""
    var sDesc = ""
    var seekerUID = ""
    var seekerContact = ""
    var seekerPassagers = ""
    
    var providerName = ""
    var providerContact = ""
    var currentDocID = ""
    let providerUID = Auth.auth().currentUser!.uid
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        seekerNameLabel.text = "Name: \(sName)"
        seekerTripLabel.text = "Trip: \(sTrip)"
        seekerTripTimeLabel.text = "Time: \(sTime)"
        seekerTripDescLabel.text = "Trip Details: \(sDesc)"
        // Do any additional setup after loading the view.
        print(seekerContact)
    }

    @IBAction func addToLogsPressed(_ sender: UIButton) {
        
        db.collection("providerLogs").addDocument(data: ["seekerName": sName, "trip": sTrip, "time": sTime, "tripDesc": sDesc, "tripPassengers": seekerPassagers, "seekerContact": seekerContact, "providerUID": providerUID, "seekerUID": seekerUID]) { (error) in
            if error != nil{
                print("error")
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else{
                let alert = UIAlertController(title: "Confirmation", message: "Successfully added to your logs!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.db.collection("seekerLogs").addDocument(data: ["providerName": self.providerName, "trip": self.sTrip, "time": self.sTime, "tripDesc": self.sDesc, "tripPassengers": self.seekerPassagers, "contact": self.providerContact, "providerUID": self.providerUID, "seekerUID": self.seekerUID])
                // delete the document form the seekerRideDetails db here
                //db.collection("seekerRideDetails").document(id).delete()
                //db.collection("providerRideDetails").document(currentDocID).delete()
            }
        }
    }
    


}
