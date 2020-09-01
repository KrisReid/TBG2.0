//
//  ManagersTableViewCell.swift
//  TBG2
//
//  Created by Kris Reid on 01/09/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class ManagersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivPlayerImage: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var btnAddRemove: UIButton!
    
    var colours = Colours()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivPlayerImage.circle(colour: colours.primaryBlue.cgColor)
        ivPlayerImage.clipsToBounds = true
    }

}
