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
    
    var colours = Colours()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivHomeTeam.circle(colour: colours.secondaryBlue.cgColor)
        ivAwayTeam.circle(colour: colours.secondaryBlue.cgColor)
    }

}
