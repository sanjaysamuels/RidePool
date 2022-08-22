//
//  PaymentViewController.swift
//  PaymentConfirmation
//
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onConfirmation(_ sender: Any) {
        if cardNumberTextField.text?.count == 14 && cvvTextField.text?.count == 4 {
            navigateToFeedBackView()
        }
    }
    
    func navigateToFeedBackView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let feedbackViewController = storyBoard.instantiateViewController(withIdentifier: "FeedBackView") as! FeedbackViewController
        self.navigationController?.pushViewController(feedbackViewController, animated: true)
    }
    
}
