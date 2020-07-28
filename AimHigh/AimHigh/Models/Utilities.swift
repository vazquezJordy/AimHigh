//
//  Utilities.swif.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 7/28/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = #colorLiteral(red: 0.7351648211, green: 0.5957276821, blue: 0.4921607971, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = #colorLiteral(red: 0.9879029393, green: 0.9880678058, blue: 0.9834874272, alpha: 1)
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.9879029393, green: 0.9880678058, blue: 0.9834874272, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = #colorLiteral(red: 0.8334732056, green: 0.6655746102, blue: 0.5399550796, alpha: 1)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
