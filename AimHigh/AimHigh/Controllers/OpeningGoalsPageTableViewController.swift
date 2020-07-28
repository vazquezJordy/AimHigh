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
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9881132245, green: 0.988348186, blue: 0.9838065505, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        db = Firestore.firestore()
        goalsCollectionRef = Firestore.firestore().collection("goal")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
        self.goalStructure.removeAll()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadData() {
        
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
                    
                    self.goalStructure.append(newObject)
                }
                self.tableView.reloadData()
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
        cell.configureCell(goalStructure: goalStructure[indexPath.row])
        
        return cell
    }
    
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //    set the segue where it's going
    //    whats getting passed on
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if let indexPath = tableView.indexPathForSelectedRow {
//            let toDetailView = segue.destination as? DetailOfGoalsViewController
//            let documentId = goalStructure[indexPath.row].documentID
//            toDetailView.documentID = documentID
//        }
        guard let vc = segue.destination as? DetailOfGoalsViewController, let index = tableView.indexPathForSelectedRow?.row else {return}
//        let documentID = goalStructure[index].documentID
//        vc.documentID
        let goal = goalStructure[index]
        vc.goal = goal
        let documentID = goal.documentID
        vc.documentID = documentID
        
    }
}
