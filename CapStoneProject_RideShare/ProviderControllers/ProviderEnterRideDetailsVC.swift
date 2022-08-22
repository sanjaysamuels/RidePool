//
//  ProviderEnterRideDetailsVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-03.
//

import UIKit
import Firebase

class ProviderEnterRideDetailsVC: UIViewController {
    
    var date = Date()
    
    var rideDetails:LogsDBModel?
    @IBOutlet weak var fromToTextField: UITextField!
    @IBOutlet weak var ToTextField: UITextField!
    @IBOutlet weak var numberOfPassengers: UITextField!
    @IBOutlet weak var rideDescriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    let uid = Auth.auth().currentUser!.uid
    let functionalConst = FunctionalConst()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionalConst.GetItemsFromFBDB(docName: "users", uid: uid)
        datePicker.minimumDate = date
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneClicked(_ sender: UIButton) {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        let strDate = dateFormatter.string(from: datePicker.date)
        let tripFrom = fromToTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let tripTo = ToTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let numPass = numberOfPassengers.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let rideDesrc = rideDescriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dateTime = strDate.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if (tripFrom == "" || tripTo == "" || numPass == ""){
            let alert = UIAlertController(title: "Alert", message: "From, To and Number of passengers fields are manditory!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if (tripFrom?.rangeOfCharacter(from: characterset.inverted) != nil || tripTo?.rangeOfCharacter(from: characterset.inverted) != nil){
            let alert = UIAlertController(title: "Alert", message: "From and To fields cannot have any special characters!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            let db = Firestore.firestore()
            let name = FunctionalConst.userName
            let cont = FunctionalConst.userContact
            db.collection("providerRideDetails").addDocument(data: ["provider_name": name, "from_to": "\(tripFrom!)-\(tripTo!)", "num_passenger": numPass!, "ride_decrp": rideDesrc!, "provider_contact": cont , "dateTime": dateTime ,"uid": uid]) { (error) in
                if error != nil{
                    print(error!)
                }
            }
            
            dismiss(animated: true, completion: nil);
        }

        
    }
    
    @IBAction func cancleClicked(_ sender: UIButton){
        dismiss(animated: true, completion: nil);
    }
    
    func getDriverName(){
        
    }
    
    
}
