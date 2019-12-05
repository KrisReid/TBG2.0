//
//  PlayerDetailViewController.swift
//  TBG2
//
//  Created by Kris Reid on 02/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    @IBOutlet weak var ivPlayerIProfilePic: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPlayerAge: UILabel!
    @IBOutlet weak var lblPlayerPosition: UILabel!
    
    var playerProfilePic: UIImage = UIImage()
    var playerName: String = String()
    var playerAge: Int = Int()
    var playerPosition: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivPlayerIProfilePic.layer.cornerRadius = ivPlayerIProfilePic.frame.width / 2
        ivPlayerIProfilePic.layer.masksToBounds = true
        ivPlayerIProfilePic.layer.borderWidth = 1.0
        ivPlayerIProfilePic.layer.borderColor = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 ).cgColor
        
        ivPlayerIProfilePic.image = playerProfilePic
        lblPlayerName.text = playerName
        lblPlayerAge.text = "\(playerAge) years old"
        lblPlayerPosition.text = playerPosition
        
    }
    

}
