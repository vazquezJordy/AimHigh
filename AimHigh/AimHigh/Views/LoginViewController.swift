//
//  LoginViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 7/27/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextFiel: UITextField!
    @IBOutlet weak var passwordTextFiel: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextFiel.text = "jvaazque@noman.com"
        passwordTextFiel.text = "abcd@1234"
       setUpElements()
    }
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextFiel)
        Utilities.styleTextField(passwordTextFiel)
         Utilities.styleFilledButton(loginButton)
    }
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailTextFiel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextFiel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                
            } else {
                
                AppDelegate.userID = result?.user.uid ?? ""
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! OpeningGoalsPageTableViewController
                let navControllor = UINavigationController(rootViewController: homeViewController)
                self.view.window?.rootViewController = navControllor
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
}
