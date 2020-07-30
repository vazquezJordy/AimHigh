//
//  GoalsTableViewCell.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/8/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import Firebase

protocol GoalTableViewCellDelegate {
    func didCompleteGoal(_ sender: GoalsTableViewCell)
}

class GoalsTableViewCell: UITableViewCell {
    
    var goalStructureCell: GoalStructure!
    var db: Firestore! = Firestore.firestore()
    var delegate: GoalTableViewCellDelegate?
    
    @IBOutlet weak var imageTableViewCell: UIImageView!
    @IBOutlet weak var overviewGoalCell: UITextField!
    @IBOutlet weak var completedButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        db = Firestore.firestore()
        
    }
    

    func configureCell(goalStructure: GoalStructure) {
        overviewGoalCell.text = goalStructure.nameOfGoal
        
        imageTableViewCell.image = goalStructure.imageGoal
        goalStructureCell = goalStructure
    }
//    let docID = sma
    @IBAction func goalCompletedTapped(_ sender: Any) {
        
        let documentID = goalStructureCell.documentID
        print(documentID)
        
        db.collection("goals").document(AppDelegate.userID).collection("goals").document(documentID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.delegate?.didCompleteGoal(self)
            }
        }
    }
    
}
