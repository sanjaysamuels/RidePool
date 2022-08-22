//
//  ProviderLoginViewController.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-03.
//

import UIKit
import FirebaseAuth
import Firebase

class ProviderLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.alpha = 0
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
                let id = Auth.auth().currentUser!.uid
                
                //print("THIS IS THE ID", id)
                if error != nil{
                    self.showError("Could not sign in!")
                } else{
                    
                    let DocRefernce:DocumentReference!
                    let db = Firestore.firestore()
                    DocRefernce = db.collection("users").document(id)
                    DocRefernce.getDocument { [self] (docSnapshot, error) in
                        if error != nil {
                            print(error!)
                        } else {
                            guard let snapshot = docSnapshot, snapshot.exists else { return }
                            guard let data = snapshot.data() else { return }
                            //let firstname = data["first_name"] as? String ?? "No name"
                            let userRole = data["user_role"] as? String ?? "No role"
                            if (userRole == "provider"){
                                self.transitionToHomeScreen()
                                //self.transitionToProviderHome()
                            } else{
                                self.showError("Sorry, you are not registered to be a provider!")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func showError(_ error: String){
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
 
    
    func transitionToHomeScreen(){
        let myTabBar = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.providerTabBar) as? UITabBarController
        //var appDelegate = UIApplication.shared.delegate as! AppDelegate
        view.window?.rootViewController = myTabBar
        view.window?.makeKeyAndVisible()
    }

}


