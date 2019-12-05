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
    var playerImage: UIImage
    var playerName: String
    var playerAge: Int
    var playerPostion: String
}

class PlayersModel {
    
    var playerList: [Player] = [Player]()
    var goalkeeperList: [Player] = [Player]()
    var defenderList: [Player] = [Player]()
    var midfielderList: [Player] = [Player]()
    var strikerList: [Player] = [Player]()
    
    init() {
        
        let player1 = Player(playerImage: UIImage(named: "player1")!, playerName: "John Carrick", playerAge: 24, playerPostion: "goalkeeper")
        playerList.append(player1)
        goalkeeperList.append(player1)
        
        let player2 = Player(playerImage: UIImage(named: "player2")!, playerName: "Dwayne Jenas", playerAge: 27, playerPostion: "defender")
        playerList.append(player2)
        defenderList.append(player2)
        
        let player3 = Player(playerImage: UIImage(named: "player1")!, playerName: "Mike Cole", playerAge: 19, playerPostion: "defender")
        playerList.append(player3)
        defenderList.append(player3)
        
        let player4 = Player(playerImage: UIImage(named: "player1")!, playerName: "Dean Reid", playerAge: 16, playerPostion: "midfielder")
        playerList.append(player4)
        midfielderList.append(player4)
        
        let player5 = Player(playerImage: UIImage(named: "player2")!, playerName: "Dean Reid", playerAge: 22, playerPostion: "midfielder")
        playerList.append(player5)
        midfielderList.append(player5)
        
        let player6 = Player(playerImage: UIImage(named: "player2")!, playerName: "Dean Reid", playerAge: 22, playerPostion: "midfielder")
        playerList.append(player6)
        midfielderList.append(player6)
        
        let player7 = Player(playerImage: UIImage(named: "player1")!, playerName: "Dean Reid", playerAge: 30, playerPostion: "striker")
        playerList.append(player7)
        strikerList.append(player7)
        
    }
}
