//
//  ProviderLogsTableDetailsVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-08.
//

import UIKit

class ProviderLogsTableDetailsVC: UIViewController {
    
    @IBOutlet weak var seekerNameLabel: UILabel!
    @IBOutlet weak var seekerTripLabel: UILabel!
    @IBOutlet weak var seekerTripTimeLabel: UILabel!
    @IBOutlet weak var seekerContactLabel: UILabel!
    @IBOutlet weak var seekerTripDescLabel: UILabel!
    
    
    var sName = ""
    var sTrip = ""
    var sTime = ""
    var sDesc = ""
    var seekerUID = ""
    var seekerContact = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        seekerNameLabel.text = "Seeker Name: \(sName)"
        seekerTripLabel.text = "From - To: \(sTrip)"
        seekerTripTimeLabel.text = "Time: \(sTime)"
        seekerTripDescLabel.text = "Trip Message: \(sDesc)"
        seekerContactLabel.text = "Seeker Contact: \(seekerContact)"
        // Do any additional setup after loading the view.
    }

    @IBAction func trackButtonPressed(_ sender: UIButton) {
        // proceed to the tracking page
    }
}
