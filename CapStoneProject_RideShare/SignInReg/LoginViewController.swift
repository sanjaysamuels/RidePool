//
//  LoginViewController.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-07-28.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        errorLabel.alpha = 0
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateInputs() -> String?{
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
         return "Please fill in all fields!"
        }
        
        return nil
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let error = validateInputs()
        if error != nil{
            showError(error!)
        } else{
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if error != nil{
                    self.showError("Could not sign in!")
                } else{
                    self.transitionToHomeScreen()
                    print(result!.user.uid)
                }
            }
        }
    }
    
    func showError(_ error: String){
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func transitionToHomeScreen(){
        let myTabBar = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.seeketTabBar) as? UITabBarController
        //var appDelegate = UIApplication.shared.delegate as! AppDelegate
        view.window?.rootViewController = myTabBar
        view.window?.makeKeyAndVisible()
    }
}
