//
//  ProviderMoreVC.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-03.
//

import UIKit
import Firebase

class ProviderMoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More"
        // Do any additional setup after loading the view.
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
