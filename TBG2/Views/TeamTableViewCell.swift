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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivPlayerImage.circle(colour: colours.primaryBlue.cgColor)
        ivPlayerImage.clipsToBounds = true
    }
}
