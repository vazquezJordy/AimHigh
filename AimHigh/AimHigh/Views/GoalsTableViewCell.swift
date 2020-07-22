//
//  GoalsTableViewCell.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/8/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTableViewCell: UIImageView!
    @IBOutlet weak var overviewGoalCell: UITextField!
    @IBOutlet weak var percentageLable: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(goalStructure: GoalStructure) {
        overviewGoalCell.text = goalStructure.nameOfGoal
        imageTableViewCell.image = goalStructure.imageGoal
    }
    

}
