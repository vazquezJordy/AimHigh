//
//  SignUpViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 7/27/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(singUpButton)
    }
    
    //    Check the fields and validate that the data is corect. If everuthing is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //        Check that all fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ==  "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all Fields"
        }
        //        check if password is valid
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if  Utilities.isPasswordValid(cleanedPassword) == false {
            //            password is not secure
            return "please make sure your password is at least 8 characters, contains 1 specail character and a number"
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        //        Validate the fields
        let error = validateFields()
        
        if error != nil {
            //            something went wrong
            showError(error!)
            
        } else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
//                check errors
                 if err != nil {
                    self.showError("Error creating user")
                } else {
                    AppDelegate.userID = result?.user.uid ?? ""
                   let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName":firstName,
                                                              "lastName": lastName,
                                                              "uid": result?.user.uid]) { (error) in
                                                                if error != nil {
                                                                    print("Error saving user data")
                                                                }
                    }
                    self.transitionToHome()
                }
            }
        }
        
        //        create the user
        
        
        //        Transition to the home screen
    }
    func transitionToHome() {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! OpeningGoalsPageTableViewController
        let navControllor = UINavigationController(rootViewController: homeViewController)
        self.view.window?.rootViewController = navControllor
        self.view.window?.makeKeyAndVisible()
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}

