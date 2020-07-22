//
//  GoalItems.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/12/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import Foundation
import UIKit

struct GoalStructure {
    let nameOfGoal: String?
    let imageGoal: UIImage
    let reasonsForGoal: [String]
    let smallSteps: [String]
    let date: Date?
}

// This is so that i cange change the color of the placeHolder Text
extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}




