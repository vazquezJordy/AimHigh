//
//  GoalItems.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/12/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import Foundation

class GoalStructure {
    
    struct GoalOverView: Codable {
        let image: String
        let goalsDetails: [ GoalInput]
        let percentageOfCompletion: Int
        
        
    }
    
    struct GoalInput: Codable {
        let nameOfGoal: String
        let purposeOfGoal: String
        let reasonForGoal: String
        let date: Date?
    }
    
    struct TouchGoalDetails: Codable {
        let reasonOfGoalsDetail: [GoalInput]
        let smallSteps: String
        let InputOfStepGoal: [InputForStepGoals]
    }
    
    struct InputForStepGoals:Codable {
        let nameOfStepGoal: String
        let date: Date?
    }
}
