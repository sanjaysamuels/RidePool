//
//  RideCompleteViewController.swift
//  Capstone_Seeker
//
//  Created by user206596 on 8/12/22.
//

import UIKit

class RideCompleteViewController: UIViewController {

    @IBOutlet weak var payNow: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func payNowButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let paymentViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        self.navigationController?.pushViewController(paymentViewController, animated: true)

    }
}
