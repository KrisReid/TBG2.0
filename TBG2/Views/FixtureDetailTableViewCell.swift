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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivPlayer.circle(colour: colours.primaryBlue.cgColor)
        ivPlayerAvailability.circle(colour: colours.primaryBlue.cgColor)
    }
    
}
