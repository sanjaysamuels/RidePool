//
//  RideRequestSubmitConfirmViewController.swift
//  Seeker2
//
//  Created by Jeswin Johncy on 2022-08-14.
//

import UIKit

class RideRequestSubmitConfirmViewController: UIViewController {
    

    
    @IBOutlet weak var metaDataLabel: UILabel!
    
    @IBAction func okBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "homePage") as! SeekerHomeVC
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    var source: String = ""
    var dest: String = ""
    var date: Date = Date()


    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = "Your ride request is shared with matching providers with details:"
        metaDataLabel.text="Source: "+source+" | Destination: "+dest
        
        
        dateLabel.text=date.description
        // Do any additional setup after loading the view.
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
