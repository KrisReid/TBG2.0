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
    var circles = Circles()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circles.circleLabels(name: lblGamesPlayedResult, colour: colours.secondaryBlue.cgColor)
        circles.circleLabels(name: lblMOTMResult, colour: colours.secondaryBlue.cgColor)
        circles.circleLabels(name: lblGoalsScoredResult, colour: colours.secondaryBlue.cgColor)

    }
    
    
    
}
