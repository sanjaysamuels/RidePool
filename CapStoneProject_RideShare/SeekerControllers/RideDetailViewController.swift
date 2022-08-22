//
//  RideDetailViewController.swift
//  Seeker2
//
//  Created by Jeswin Johncy on 2022-08-13.
//

import UIKit

class RideDetailViewController: UIViewController {
    @IBOutlet weak var rideTitle: UILabel!
    @IBOutlet weak var rideTime: UILabel!
    @IBOutlet weak var rideProvider: UILabel!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var rideVehicle: UILabel!
    var ride: String = ""
    var time: String = ""
    var provider: String = ""
    var vehicle: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        rideTitle.text=ride
        rideTime.text=time
        rideProvider.text=provider
        rideVehicle.text=vehicle
        
        requestBtn.addTarget(self, action: #selector(goDetail), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func goDetail(){
        guard let vc = storyboard?.instantiateViewController(identifier: "RideConfirm") as? RideConfirmViewController else {
            return
        }
        vc.provider=provider
        vc.title=ride
        vc.vehicle=vehicle
        //vc.modalPresentationStyle = .fullScreen
        //present(vc, animated: true, completion: nil)
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
