//
//  TeamTableViewCell.swift
//  TBG2
//
//  Created by Kris Reid on 18/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    lazy var players: [Player] = {
        let model = PlayersModel()
        return model.playerList
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
