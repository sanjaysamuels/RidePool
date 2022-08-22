//
//  ProviderTableDetailsVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-04.
//

import UIKit

class ProviderTableDetailsVC: UIViewController {

    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerTripLabel: UILabel!
    @IBOutlet weak var providerTripTimeLabel: UILabel!
    @IBOutlet weak var providerTripDescLabel: UILabel!
    
    var pName = ""
    var pTrip = ""
    var pTime = ""
    var pDesc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        providerNameLabel.text = "Name: \(pName)"
        providerTripLabel.text = "Trip: \(pTrip)"
        providerTripTimeLabel.text = "Time: \(pTime)"
        providerTripDescLabel.text = "Trip Details: \(pDesc)"
        // Do any additional setup after loading the view.
    }

}
