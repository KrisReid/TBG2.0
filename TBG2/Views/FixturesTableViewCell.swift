//
//  FixturesTableViewCell.swift
//  TBG2
//
//  Created by Kris Reid on 28/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class FixturesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblOpposition: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var ivHomeAway: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
