////
////  GoalGetter.swift
////  AimHigh
////
////  Created by Jordy Vazquez on 7/23/20.
////  Copyright © 2020 Jordy Vazquez. All rights reserved.
////
//
//import Foundation
//import Firebase
//import FirebaseDatabase
//
//
//class GoalGetter {
//
//    var db: Firestore! = Firestore.firestore()
//    var goalStructure: [GoalStructure] = []
//
//    func getGoalDetails() {
//
//        let goalCollecgtionRef = db.collection("goals")
//        goalCollecgtionRef.getDocuments { (querySapshot, err) in
//            if let docs = querySapshot?.documents {
//                for docSnapshot in docs {
//                    let nameOfGoalOutPut = docSnapshot["nameOfGoal"] as? String ?? "No value"
//                    print(nameOfGoalOutPut.count)
//                    //                    guard docSnapshot["goalImage"] != nil else {print("The is no image"); continue}
//                    guard let imageOutData = docSnapshot["goalImage"] as? String else {print(" I'm not a string... My type is \(type(of: docSnapshot["goalImage"]!))"); continue}
//                    let date = docSnapshot["date"] as? Date ?? Date()
//                    let reasonForGoal1 = docSnapshot["reasonForGoal1"] as? String ?? "No value"
//                    let reasonForGoal2 = docSnapshot["reasonForGoal2"] as? String ?? "No value"
//                    let reasonForGoal3 = docSnapshot["reasonForGoal3"] as? String ?? "No value"
//                    let image = self.converBase64StringToImage(imageBase64String: imageOutData)
//                    print(image)
//
//                    let newObject = GoalStructure(nameOfGoal: nameOfGoalOutPut, imageGoal: image, reasonsForGoal: [reasonForGoal1, reasonForGoal2, reasonForGoal3], smallSteps: ["nil"], date: date)
//
//                    self.goalStructure.append(newObject)
//                }
//            }
//        }
//    }
//    func converBase64StringToImage (imageBase64String:String) -> UIImage {
//        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
//        let image = UIImage(data: imageData!)
//        return image!
//    }
//}
