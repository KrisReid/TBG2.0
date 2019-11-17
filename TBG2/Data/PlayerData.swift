//
//  PlayerData.swift
//  TBG2
//
//  Created by Kris Reid on 17/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit

struct Player {
    
    var playerName: String
    var playerImage: UIImage
    
}

class PlayersModel {
    
    var playerList: [Player] = [Player]()
    
    init() {
        
        let player1 = Player(playerName: "John Carrick", playerImage: UIImage(named: "player1")!)
        playerList.append(player1)
        
        let player2 = Player(playerName: "Dwayne Jenas", playerImage: UIImage(named: "player2")!)
        playerList.append(player2)
        
        let player3 = Player(playerName: "Mike Cole", playerImage: UIImage(named: "player1")!)
        playerList.append(player3)
        
    }
    
    
}
