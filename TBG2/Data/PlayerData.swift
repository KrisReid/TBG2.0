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
    var playerPostion: String
}

class PlayersModel {
    
    var playerList: [Player] = [Player]()
    var goalkeeperList: [Player] = [Player]()
    var defenderList: [Player] = [Player]()
    var midfielderList: [Player] = [Player]()
    var strikerList: [Player] = [Player]()
    
    init() {
        
        let player1 = Player(playerName: "John Carrick", playerImage: UIImage(named: "player1")!, playerPostion: "goalkeeper")
        playerList.append(player1)
        goalkeeperList.append(player1)
        
        let player2 = Player(playerName: "Dwayne Jenas", playerImage: UIImage(named: "player2")!, playerPostion: "defender")
        playerList.append(player2)
        defenderList.append(player2)
        
        let player3 = Player(playerName: "Mike Cole", playerImage: UIImage(named: "player1")!, playerPostion: "defender")
        playerList.append(player3)
        defenderList.append(player3)
        
        let player4 = Player(playerName: "Dean Reid", playerImage: UIImage(named: "player1")!, playerPostion: "midfielder")
        playerList.append(player4)
        midfielderList.append(player4)
        
        let player5 = Player(playerName: "Dean Reid", playerImage: UIImage(named: "player2")!, playerPostion: "midfielder")
        playerList.append(player5)
        midfielderList.append(player5)
        
        let player6 = Player(playerName: "Dean Reid", playerImage: UIImage(named: "player2")!, playerPostion: "midfielder")
        playerList.append(player6)
        midfielderList.append(player6)
        
        let player7 = Player(playerName: "Dean Reid", playerImage: UIImage(named: "player1")!, playerPostion: "striker")
        playerList.append(player7)
        strikerList.append(player7)
        
    }
}
