//
//  Slide.swift
//  TBG2
//
//  Created by Kris Reid on 05/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class Slide: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGamesPlayedResult: UILabel!
    @IBOutlet weak var lblMOTMResult: UILabel!
    @IBOutlet weak var lblGoalsScoredResult: UILabel!
    
    var colours = Colours()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblGamesPlayedResult.layer.cornerRadius = lblGamesPlayedResult.frame.width / 2
        lblGamesPlayedResult.layer.masksToBounds = true
        lblGamesPlayedResult.layer.borderWidth = 1.0
        lblGamesPlayedResult.layer.borderColor = colours.secondaryBlue.cgColor
        
        lblMOTMResult.layer.cornerRadius = lblMOTMResult.frame.width / 2
        lblMOTMResult.layer.masksToBounds = true
        lblMOTMResult.layer.borderWidth = 1.0
        lblMOTMResult.layer.borderColor = colours.secondaryBlue.cgColor
        
        lblGoalsScoredResult.layer.cornerRadius = lblGoalsScoredResult.frame.width / 2
        lblGoalsScoredResult.layer.masksToBounds = true
        lblGoalsScoredResult.layer.borderWidth = 1.0
        lblGoalsScoredResult.layer.borderColor = colours.secondaryBlue.cgColor
    }
    
    
    
}
