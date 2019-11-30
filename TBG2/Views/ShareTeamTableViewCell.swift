//
//  ShareTeamTableViewCell.swift
//  TBG2
//
//  Created by Kris Reid on 28/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class ShareTeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    lazy var lblOption: UILabel = {
        let lblOption = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        return lblOption
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addSubview(lblOption)
//        addSubview(textLabel)
        
        if let textlbl = textLabel as? UILabel {
            addSubview(textlbl)
        }
            
    }
    
}
