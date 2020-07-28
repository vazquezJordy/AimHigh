//
//  HomeLoginViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 7/27/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit

class HomeLoginViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    

}
