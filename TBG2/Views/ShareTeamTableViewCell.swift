//
//  ShareTeamTableViewCell.swift
//  TBG2
//
//  Created by Kris Reid on 28/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class ShareTeamTableViewCell: UITableViewCell {
    
    var colours = Colours()
    
    lazy var lblOption: UILabel = {
        let lblOption = UILabel(frame: CGRect(x: 25, y: 0, width: 100, height: 60))
        return lblOption
    }()
    
    lazy var lblAnswer: UILabel = {
        let lblAnswer = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 225, y: 0, width: 200, height: 60))
        lblAnswer.textAlignment = .right
        lblAnswer.textColor = colours.priaryGrey
        return lblAnswer
    }()
    
    lazy var ivAnswer: UIImageView = {
        let ivAnswer = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 25, height: 60))
        ivAnswer.contentMode = .scaleAspectFit
        return ivAnswer
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addSubview(lblOption)
        addSubview(lblAnswer)
        addSubview(ivAnswer)
            
    }
    
}
