//
//  FeedbackViewController.swift
//  PaymentConfirmation
//

//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClose(_ sender: Any) {
        //TODO jump to home screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let homeController = storyBoard.instantiateViewController(withIdentifier: "homePage") as! SeekerHomeVC
                self.navigationController?.pushViewController(homeController, animated: true)
    }

}
