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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblGamesPlayedResult.layer.cornerRadius = lblGamesPlayedResult.frame.width / 2
        lblGamesPlayedResult.layer.masksToBounds = true
        lblGamesPlayedResult.layer.borderWidth = 1.0
        lblGamesPlayedResult.layer.borderColor = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 ).cgColor
    }
    
}
