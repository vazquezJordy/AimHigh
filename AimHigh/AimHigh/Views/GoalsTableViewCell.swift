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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
