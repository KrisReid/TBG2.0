//
//  ShareTeamView.swift
//  TBG2
//
//  Created by Kris Reid on 24/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class ShareTeamView: UIView {

    @IBOutlet weak var ivClubBadge: UIImageView!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblClubPostcode: UILabel!
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        ivClubBadge.layer.cornerRadius = ivClubBadge.frame.width / 2
        ivClubBadge.layer.masksToBounds = true
        ivClubBadge.layer.borderWidth = 1.0
        ivClubBadge.layer.borderColor = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 ).cgColor
    
    }
    

}
