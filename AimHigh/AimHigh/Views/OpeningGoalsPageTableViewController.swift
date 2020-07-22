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

class OpeningGoalsPageTableViewController: UITableViewController {
    
    
    var ref: DatabaseReference?
    var goalStructure: [GoalStructure] = []
    var db: Firestore! = Firestore.firestore()
    private var goalsCollectionRef: CollectionReference!
    
    
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        goalsCollectionRef = Firestore.firestore().collection("goals")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        goalsCollectionRef.getDocuments { (snapshot, error) in
        //            if let err = error {
        //                debugPrint("error fetching docs \(err)")
        //            } else {
        //                let ramdomID = UUID.init().uuidString
        //                guard let snap = snapshot else {return}
        //                for document in snap.documents {
        //                    let data = document.data()
        //                    let nameOfGoal = data["nameOfGoal"] as? String ?? "No value"
        //                    let date = data["date"] as? Date ?? Date()
        //
        //                    let reasonForGoal1 = data["reasonForGoal1"] as? String ?? "No value"
        //                    let reasonForGoal2 = data["reasonForGoal2"] as? String ?? "No value"
        //                    let reasonForGoal3 = data["reasonForGoal3"] as? String ?? "No value"
        //                    let imageGoal = data["imageGoal"] as! UIImage
        //
        //                    //
        //                    //                    let goalInput = GoalInput(nameOfGoal: T##String, reasonsForGoal: T##[String], date: T##Data?, imageInput: T##[ImageOfGoal])
        //
        //                }
        //            }
        //        }
        
        let goalCollecgtionRef = db.collection("goals")
        goalCollecgtionRef.getDocuments { (querySapshot, err) in
            if let docs = querySapshot?.documents {
                for docSnapshot in docs {
                    let nameOfGoalOutPut = docSnapshot["nameOfGoal"] as? String ?? "No value"
                    print(nameOfGoalOutPut.count)
                    guard docSnapshot["goalImage"] != nil else {print("The is no image"); continue}
                    guard let imageOutData = docSnapshot["goalImage"] as? String else {print(" I'm not a string... My type is \(type(of: docSnapshot["goalImage"]!))"); continue}
                    let date = docSnapshot["date"] as? Date ?? Date()
                    let reasonForGoal1 = docSnapshot["reasonForGoal1"] as? String ?? "No value"
                    let reasonForGoal2 = docSnapshot["reasonForGoal2"] as? String ?? "No value"
                    let reasonForGoal3 = docSnapshot["reasonForGoal3"] as? String ?? "No value"
                    let image = self.converBase64StringToImage(imageBase64String: imageOutData)
                    print(image)
                    
                    //                    we need to save the above into GoalOverview
                    //                    and then append it
                    let newObject = GoalStructure(nameOfGoal: nameOfGoalOutPut, imageGoal: image, reasonsForGoal: [reasonForGoal1, reasonForGoal2, reasonForGoal3], smallSteps: ["nil"], date: date)
                    //                        GoalOverView(nameOfGoal: nameOfGoalOutPut, imageGoal: image)
                    
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
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overViewOfGoals", for: indexPath) as! GoalsTableViewCell
        cell.configureCell(goalStructure: goalStructure[indexPath.row])
        
        return cell
    }
    
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
    //    set the segue where it's going
    //    whats getting passed on
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = DetailOfGoalsViewController()
//        let goalCollecgtionRef = db.collection("goals")
//        goalCollecgtionRef.getDocuments { (querySapshot, err) in
//            if let docs = querySapshot?.documents {
//                for docSnapshot in docs {
//
//                    let reasonForGoal1 = docSnapshot["reasonForGoal1"] as? String ?? "No value"
//                    let reasonForGoal2 = docSnapshot["reasonForGoal2"] as? String ?? "No value"
//                    let reasonForGoal3 = docSnapshot["reasonForGoal3"] as? String ?? "No value"
//
//                    let reasonForGoal = self.goalStructure.
//                    
//                    vc.reasonOfGoalOutPut1 = self.goalStructure.
//                    vc.reasonOfGoalOutPut2
//                    vc.reasonOfGoalOutPut3
//                }
//            }
//        }
    }
}
