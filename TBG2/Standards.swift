//
//  Standards.swift
//  TBG2
//
//  Created by Kris Reid on 06/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit



class Colours {
    
    var primaryBlue = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 )
    var secondaryBlue = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 )
    var priaryGrey = UIColor( red: 120/255, green: 120/255, blue:120/255, alpha: 1.0 )
    
}


class Circles {
    
    func circles (name: UIImageView, colour: CGColor) {
        name.layer.cornerRadius = name.frame.width / 2
        name.layer.masksToBounds = true
        name.layer.borderWidth = 1.0
        name.layer.borderColor = colour
    }
    
    func circleLabels (name: UILabel, colour: CGColor) {
        name.layer.cornerRadius = name.frame.width / 2
        name.layer.masksToBounds = true
        name.layer.borderWidth = 1.0
        name.layer.borderColor = colour
    }
    
}

