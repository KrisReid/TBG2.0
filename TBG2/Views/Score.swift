//
//  Score.swift
//  TBG2
//
//  Created by Kris Reid on 20/01/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit



class Score: UIView {

    @IBOutlet weak var ivHomeTeam: UIImageView!
    @IBOutlet weak var ivAwayTeam: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    
    // Outlets to have the VC update the teams score based on goal scorers
    
    var colours = Colours()
    var homeGoalCount = 0
    var awayGoalCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivHomeTeam.circle(colour: colours.secondaryBlue.cgColor)
        ivAwayTeam.circle(colour: colours.secondaryBlue.cgColor)
        
        lblScore.text = "0 - 0"
    }
    
    @IBAction func HomeScoreDecrementTapped(_ sender: Any) {
        if homeGoalCount != 0 {
            homeGoalCount -= 1
            lblScore.text = "\(homeGoalCount) - \(awayGoalCount)"
        }
    }
    
    @IBAction func HomeScoreIncrementTapped(_ sender: Any) {
        homeGoalCount += 1
        lblScore.text = "\(homeGoalCount) - \(awayGoalCount)"
    }
    
    @IBAction func AwayScoreDecrementTapped(_ sender: Any) {
        if awayGoalCount != 0 {
            awayGoalCount -= 1
            lblScore.text = "\(homeGoalCount) - \(awayGoalCount)"
        }
    }
    
    @IBAction func AwayScoreIncrementTapped(_ sender: Any) {
        awayGoalCount += 1
        lblScore.text = "\(homeGoalCount) - \(awayGoalCount)"
    }

}
