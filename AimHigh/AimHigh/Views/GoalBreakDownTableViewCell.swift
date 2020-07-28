//
//  GoalBreakDownTableViewCell.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 7/23/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit

class GoalBreakDownTableViewCell: UITableViewCell {
    
    var smallGoalBreakDown: SmallGoalStructure!
    
    @IBOutlet weak var smallGoalName: UILabel!
    @IBOutlet weak var dateOfSmallGoal: UILabel!
    @IBOutlet weak var buttonForNotes: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configureCell(smallGoalStructure: SmallGoalStructure){
        smallGoalName.text = smallGoalStructure.smallNameOfGoal
        dateOfSmallGoal.text = smallGoalStructure.smallDate.date
        smallGoalBreakDown = smallGoalStructure
    }
    
}
