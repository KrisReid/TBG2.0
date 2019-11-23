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

    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        ivPlayerImage.layer.cornerRadius = ivPlayerImage.frame.width / 2
        ivPlayerImage.layer.masksToBounds = true
        ivPlayerImage.layer.borderWidth = 1.0
        ivPlayerImage.layer.borderColor = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 ).cgColor
        
//        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
}
