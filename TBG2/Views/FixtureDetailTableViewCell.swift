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
    @IBOutlet weak var ivMoney: UIImageView!
    @IBOutlet weak var ivMotmAward: UIImageView!
    @IBOutlet weak var ivGoalScored: UIImageView!
    @IBOutlet weak var lblGoalScoredCount: UILabel!
    
    
    var colours = Colours()
    var goalCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivPlayer.circle(colour: colours.primaryBlue.cgColor)
        ivPlayerAvailability.circle(colour: UIColor.clear.cgColor)
    }
    
}
