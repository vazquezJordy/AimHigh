//
//  DetailOfGoalsViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/14/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class DetailOfGoalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewForSmallGoals: UITableView!
    
    var goal: GoalStructure?
    var documentID: String!
    var db: Firestore! = Firestore.firestore()
    
    var smallGoalStructure: [SmallGoalStructure] = []
    
    @IBOutlet weak var reasonOfGoalOutPut1: UILabel!
    @IBOutlet weak var reasonOfGoalOutPut2: UILabel!
    @IBOutlet weak var reasonOfGoalOutPut3: UILabel!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(true)
        
        db = Firestore.firestore()
        
        navigationItem.title = goal?.nameOfGoal
        
        guard let goal = goal else {return}
//  Setting Reason For goasl
        if goal.reasonsForGoal.count > 0 {
            reasonOfGoalOutPut1.text = goal.reasonsForGoal[0]
        }
        if goal.reasonsForGoal.count > 1 {
            reasonOfGoalOutPut2.text = goal.reasonsForGoal[1]
        }
        if goal.reasonsForGoal.count > 2 {
            reasonOfGoalOutPut3.text = goal.reasonsForGoal[2]
        }
        getSmallGoalData()
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.getSmallGoalData()
        self.smallGoalStructure.removeAll()
        
    }
    
//   Getting Data back for smaller goal
    func getSmallGoalData(){
        db.collection("goals").document(AppDelegate.userID).collection("goals").document(documentID).collection("breakDownOfGoal").getDocuments { (querySnapshot, err) in
            if let docs = querySnapshot?.documents {
                for docSnapshot in docs {
                    let smallNameOfGoal = docSnapshot["smallNameOfGoal"] as? String ?? "No Value"
                    let smallDate = docSnapshot["smallDate"] as? Date ?? Date()
                    let goalNotes = docSnapshot["goalNotes"] as? String ?? "No Value"
                    let smallGoaldocumentID = docSnapshot.documentID
                
                    print(smallNameOfGoal, smallDate, goalNotes, smallGoaldocumentID)
                    let newSmallGoalObject = SmallGoalStructure(smallNameOfGoal: smallNameOfGoal, smallDate: smallDate, goalNotes: goalNotes, document: smallGoaldocumentID)
                    
                    if let index = self.smallGoalStructure.firstIndex(of: newSmallGoalObject) {
                         self.smallGoalStructure[index] = newSmallGoalObject
                    } else {
                        self.smallGoalStructure.append(newSmallGoalObject)
                    }
                    DispatchQueue.main.async {
                        self.tableViewForSmallGoals.reloadData()
                        
                    }
                }
            }
        }
    }
    
    //    TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return smallGoalStructure.count
    }
    
    func numberOfSections(in: UITableView) -> Int {
               return 1
           }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "smallGoalDetails", for: indexPath) as! GoalBreakDownTableViewCell
        cell.configureCell(smallGoalStructure: smallGoalStructure[indexPath.row])
        cell.documentID = goal?.documentID
        
        return cell
    }
    
//    Segues
//    This unwinds from the done button
    @IBAction func detailViewControllerUnwind(_ seg: UIStoryboardSegue) {
          
      }
//    This prepares and passes documentID for the small goal input
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SmallerGoalsInputViewController {
            let vc = segue.destination as? SmallerGoalsInputViewController
            vc?.documentID = goal?.documentID
        }
        
    }
    

    @IBAction func smallGoalsBackToDetailView(_ seg: UIStoryboardSegue) {

    }
}
    

