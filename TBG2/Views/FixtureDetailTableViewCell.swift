//
//  FixtureDetailTableViewCell.swift
//  TBG2
//
//  Created by Kris Reid on 19/01/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class FixtureDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivPlayer: UIImageView!
    @IBOutlet weak var ivPlayerAvailability: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var btnGoalDecrement: UIButton!
    @IBOutlet weak var btnGoalIncrement: UIButton!
    @IBOutlet weak var lblGoal: UILabel!
    
    var colours = Colours()
    var goalCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivPlayer.circle(colour: colours.primaryBlue.cgColor)
        ivPlayerAvailability.circle(colour: colours.primaryBlue.cgColor)
    }
    
    @IBAction func btnGoalIncrementTapped(_ sender: Any) {
        goalCount += 1
        lblGoal.text = String(goalCount)
        
    }
    
    @IBAction func btnGoalDecrementTapped(_ sender: Any) {
        if goalCount != 0 {
            goalCount -= 1
            lblGoal.text = String(goalCount)
        }
    }
    
    
}
