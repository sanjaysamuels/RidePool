//
//  SeekerMoreVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-11.
//

import UIKit
import Firebase

class SeekerMoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func providerRegistrationPressed(_ sender: UIButton) {
        UIApplication.shared.open(NSURL(string: "https://forms.gle/Jd7SkhnDX7Q4jE2MA")! as URL)
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
        }
        catch let signOutError{
            self.present(UIAlertController(title: "Error", message: signOutError.localizedDescription, preferredStyle: .alert), animated: true)
            
        }
        
        transitionToMainScreen()
    }
    
    func transitionToMainScreen(){
        let mainViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mainVC) as? ViewController
        
        view.window?.rootViewController = mainViewController
        view.window?.makeKeyAndVisible()
    }
}
