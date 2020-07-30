//
//  GoalBreakDownTableViewCell.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 7/23/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import Firebase


class GoalBreakDownTableViewCell: UITableViewCell {
    
    var smallGoalBreakDown: SmallGoalStructure!
    var documentID: String!
    var getDocumentID: SmallGoalStructure?
    var db: Firestore! = Firestore.firestore()
    
    @IBOutlet weak var smallGoalName: UILabel!
    @IBOutlet weak var dateOfSmallGoal: UILabel!
    @IBOutlet weak var buttonForNotes: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        db = Firestore.firestore()
        // Initialization code
        guard let smallGoalBreakDown = smallGoalBreakDown else {return}
        print(smallGoalBreakDown.document)
    }
    
    
//    let stringDate = goalDateFormatter.string(from: newGoalDatePicker.date)
//goalDateFormatter.dateStyle = .full
    func configureCell(smallGoalStructure: SmallGoalStructure){
        goalDateFormatter.dateStyle = .medium
        let stringDate = goalDateFormatter.string(from: smallGoalStructure.smallDate!)
        smallGoalName.text = smallGoalStructure.smallNameOfGoal
        dateOfSmallGoal.text = stringDate
        smallGoalBreakDown = smallGoalStructure
    }
    
    @IBAction func doneButtonPressed(_ sender: Any){
//        guard let smallGoalBreakDown = smallGoalBreakDown else {return
//
//        }
        
        guard let document = smallGoalBreakDown?.document else {return}
        print(document)
        
        let deleteSmallGoal = db.collection("goals").document(AppDelegate.userID).collection("goals").document(documentID).collection("breakDownOfGoal").document(document)
            
            deleteSmallGoal.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                
            }
        }
    }
    
    
//    @IBAction func notesButtonTapped(_ sender: Any) {
//        let alert = UIAlertController(title: "\(smallGoalBreakDown.goalNotes)", message: nil, preferredStyle: .alert)
//        let exit = UIAlertAction(title: "exit", style: .default) { (alertAction) in }
//        
//        alert.addAction(exit)
//        
//        
//    }
    
}
