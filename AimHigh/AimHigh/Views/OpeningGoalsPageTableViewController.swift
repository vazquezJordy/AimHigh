//
//  OpeningGoalsPageTableViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/8/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseDatabase
import Firebase
import FirebaseCore
import FirebaseAuth

class OpeningGoalsPageTableViewController: UITableViewController {
    
    
    var ref: DatabaseReference?
    var goalStructure: [GoalStructure] = []
    var db: Firestore! = Firestore.firestore()
    private var goalsCollectionRef: CollectionReference!
    let storageRef = Storage.storage().reference()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.7346218228, green: 0.5962660313, blue: 0.4919709563, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        db = Firestore.firestore()
        goalsCollectionRef = Firestore.firestore().collection("goal")
        self.loadData()
        navigationItem.leftBarButtonItem = editButtonItem

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.loadData()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    
    func loadData() {
        goalStructure.removeAll()
        let goalCollecgtionRef = db.collection("goals").document(AppDelegate.userID).collection("goals")
        goalCollecgtionRef.getDocuments { (querySapshot, err) in
            if let docs = querySapshot?.documents {
                for docSnapshot in docs {
                    let nameOfGoalOutPut = docSnapshot["nameOfGoal"] as? String ?? "No value"
                    guard docSnapshot["goalImage"] != nil else {print("The is no image"); continue}
                    guard let imageOutData = docSnapshot["goalImage"] as? String else {print(" I'm not a string... My type is \(type(of: docSnapshot["goalImage"]!))"); continue}
                    let date = docSnapshot["date"] as? Date ?? Date()
                    let reasonForGoal1 = docSnapshot["reasonForGoal1"] as? String ?? "No value"
                    let reasonForGoal2 = docSnapshot["reasonForGoal2"] as? String ?? "No value"
                    let reasonForGoal3 = docSnapshot["reasonForGoal3"] as? String ?? "No value"
                    let image = self.converBase64StringToImage(imageBase64String: imageOutData)
                    
                    let documentID = docSnapshot.documentID
                    
                    let newObject = GoalStructure(nameOfGoal: nameOfGoalOutPut, imageGoal: image, reasonsForGoal: [reasonForGoal1, reasonForGoal2, reasonForGoal3], date: date, documentID: documentID)
                    
//                    if let index = self.goalStructure.firstIndex(of: newObject){
//                        
//                    }
                    self.goalStructure.append(newObject)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func converBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return goalStructure.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overViewOfGoals", for: indexPath) as! GoalsTableViewCell
        cell.delegate = self
        cell.configureCell(goalStructure: goalStructure[indexPath.row])
        
        return cell
    }
    
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
          let editGoal = UITableViewRowAction(style: .normal, title: "Edit Goal") { (action, indexPath) in
            
//            let vc: NewGoalInputViewController = NewGoalInputViewController()
//            vc.deleteButton.alpha = 1
//            vc.updateButton.alpha = 1
//
//            This is for mikes help and also the keep user logged in
//            I need to get data to pass and to have update and delete button appear also have save button dissapier haha
            self.performSegue(withIdentifier: "editCurrentGoal", sender: indexPath)
        }
                    
        editGoal.backgroundColor = UIColor.brown
            
          
          return [editGoal]
        
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    //    set the segue where it's going
    //    whats getting passed on
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        editCurrentGoal
        //        toNewGoal
        
        
        
        
        
        if segue.identifier == "toNewGoal", let vc = segue.destination as? NewGoalInputViewController {
            
        }
        
        if segue.identifier == "editCurrentGoal", let vc = segue.destination as? NewGoalInputViewController, let indexPath = sender as? IndexPath {
            let goal = goalStructure[indexPath.row]
            vc.goal = goal
            
        }
        
        if segue.identifier == "toDetailView", let vc = segue.destination as? DetailOfGoalsViewController, let index = tableView.indexPathForSelectedRow?.row {
            let goal = goalStructure[index]
            let documentID = goal.documentID
            vc.documentID = documentID
            vc.goal = goal
        }
    }
}
extension OpeningGoalsPageTableViewController: GoalTableViewCellDelegate {
    func didCompleteGoal(_ sender: GoalsTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        goalStructure.remove(at: indexPath.row)
        tableView.reloadData()
    }
}
