//
//  HomeLoginViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 7/27/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import Firebase
class HomeLoginViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser != nil {
//            let newViewController: OpeningGoalsPageTableViewController = OpeningGoalsPageTableViewController()
//            self.present(newViewController, animated: true, completion: nil)
//        }
    }
    
    
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
    }
    
 


}
//    func authenticateUserAndconfigureView() {
//         if Auth.auth().currentUser == nil {
//             DispatchQueue.main.async {
//                 let navController = UINavigationController(rootViewController: HomeLoginViewController())
//                 self.present(navController, animated: true, completion: nil)
//             }
//         } else {
//            let secondNavController = UINavigationController(rootViewController: OpeningGoalsPageTableViewController)
//            self.present(secondNavController, animated: true, completion: nil)
//        }
//     }
