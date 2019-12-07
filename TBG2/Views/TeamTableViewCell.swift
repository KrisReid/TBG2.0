//
//  TeamTableViewCell.swift
//  TBG2
//
//  Created by Kris Reid on 18/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivPlayerImage: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!

    var colours = Colours()
    var circles = Circles()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circles.circles(name: ivPlayerImage, colour: colours.primaryBlue.cgColor)
    }
    
}
