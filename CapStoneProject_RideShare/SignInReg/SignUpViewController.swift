//
//  SignUpViewController.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-07-28.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var contactTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    func validateInputs() -> String?{
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            contactTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
         return "Please fill in all fields!"
        }
        
        return nil
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let error = validateInputs()
        
        if error != nil{
            showError(error!)
        } else{
            let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let contact = contactTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create a user
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                if err != nil{
                    self.showError("Error creating user")
                } else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["first_name": firstName!, "last_name": lastName!, "contact": contact!, "user_role": "seeker" ,"uid": result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("User data coudnt be added")
                        }
                    }
                    
                    self.transitionToHomeScreen()
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
