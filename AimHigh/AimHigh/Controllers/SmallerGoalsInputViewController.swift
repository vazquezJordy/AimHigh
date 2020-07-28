//
//  SmallerGoalsInputViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/14/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class SmallerGoalsInputViewController: UIViewController {

    @IBOutlet weak var smallGoalNameInput: UITextField!
    @IBOutlet weak var notesLable: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var askingDateLable: UILabel!
    @IBOutlet weak var smallGoalDatePicker: UIDatePicker!
    
    var db: Firestore! = Firestore.firestore()
    var ref: DatabaseReference?
    var documentID: String!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func doneButtonClicked(_ unwindSegue: UIStoryboardSegue) {
        goalDateFormatter.dateStyle = .full
        var ref: DocumentReference? = nil
        
        let stringDate = goalDateFormatter.string(from: smallGoalDatePicker.date)
        
        db.collection("goals").document(AppDelegate.userID).collection("goals").document(documentID).collection("breakDownOfGoal").addDocument(data: [
            "smallNameOfGoal": smallGoalNameInput.text as? String,
            "goalNotes": notesTextView.text as? String,
            "smallDate": stringDate
        ])
        
        performSegue(withIdentifier: "unwindBackToDetailView", sender: self)
        
    }
}
