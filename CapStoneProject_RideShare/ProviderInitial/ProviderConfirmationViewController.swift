//
//  ProviderConfirmationViewController.swift
//  Seeker2
//
//  Created by user206596 on 8/14/22.
//

import UIKit

class ProviderConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        transitionToHomeScreen()
    }
    
    
    func transitionToHomeScreen(){
        let myTabBar = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.providerTabBar) as? UITabBarController
        
        view.window?.rootViewController = myTabBar
        view.window?.makeKeyAndVisible()
    }
    
}

//ProviderRequestedRidesVC
