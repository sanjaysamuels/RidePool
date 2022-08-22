//
//  RideConfirmViewController.swift
//  Seeker2
//
//  Created by Jeswin Johncy on 2022-08-13.
//

import UIKit

class RideConfirmViewController: UIViewController {
    var provider: String = ""
    var ride: String = ""
    var vehicle: String = ""
    @IBOutlet weak var rideMsg: UILabel!
    @IBOutlet weak var RideTrackBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        rideMsg.text=provider+" has confirmed your request!"
        // Do any additional setup after loading the view.
        
        RideTrackBtn.addTarget(self, action: #selector(goDetail), for: .touchUpInside)
    }
    @objc func goDetail(){
        guard let vc = storyboard?.instantiateViewController(identifier: "RideTrack") as? RideTrackingViewController else {
            return
        }
        vc.provider=provider
        vc.title=ride
        vc.vehicle=vehicle
        //vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated:true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
