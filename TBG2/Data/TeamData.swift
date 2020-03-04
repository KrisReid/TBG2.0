//
//  TeamData.swift
//  TBG2
//
//  Created by Kris Reid on 17/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit

struct GamePlayer {
    var id: Int
    var playerImage: UIImage
    var playerName: String
    var playerAvailable: String
}

struct Fixture {
    var time: String
    var date: String
    var opposition: String
    var hosts: String
    var homeFixture: Bool
    var postcode: String
    var homeGoals: String
    var awayGoals: String
    var players: [GamePlayer]
}

struct Team {
    var teamId: String
    var teamPIN: Int
    var teamName: String
    var teamPostcode: String
    var teamImage: UIImage
    var fixtures: [Fixture]
}



class TeamModel {
    
    var teamList: [Team] = [Team]()
    
    init() {
        
        let player1 = GamePlayer(id: 1, playerImage: UIImage(named: "player1")!, playerName: "John Carrick", playerAvailable: "")
        
        let player2 = GamePlayer(id: 2, playerImage: UIImage(named: "player2")!, playerName: "Dwayne Jenas", playerAvailable: "")
        
        let player3 = GamePlayer(id: 3, playerImage: UIImage(named: "player1")!, playerName: "Mike Cole", playerAvailable: "")
        
        let player4 = GamePlayer(id: 4, playerImage: UIImage(named: "player1")!, playerName: "Dean Reid", playerAvailable: "")
        
        let player5 = GamePlayer(id: 5, playerImage: UIImage(named: "player2")!, playerName: "Dean Reid", playerAvailable: "Yes")
        
        let player6 = GamePlayer(id: 6, playerImage: UIImage(named: "player2")!, playerName: "Dean Reid", playerAvailable: "No")
        
        let player7 = GamePlayer(id: 7, playerImage: UIImage(named: "player1")!, playerName: "Dean Reid", playerAvailable: "Yes")
        
        let fixture1 = Fixture(time: "15:00", date: "20-10-2019", opposition: "Challengers FC", hosts: "Avonmouth FC", homeFixture: true, postcode: "AL8 7SH", homeGoals: "2", awayGoals: "0", players: [player1, player2, player3, player4, player5, player6, player7])
        let fixture2 = Fixture(time: "17:00", date: "27-10-2019", opposition: "Bolltox FC", hosts: "Avonmouth FC", homeFixture: true, postcode: "BS11 0HY", homeGoals: "5", awayGoals: "5", players: [player1, player2, player3, player4, player5, player6, player7])
        let fixture3 = Fixture(time: "15:00", date: "06-11-2019", opposition: "Assticit FC", hosts: "Avonmouth FC", homeFixture: false, postcode: "BH12 8DD", homeGoals: "-", awayGoals: "-", players: [player1, player2, player3, player4, player5, player6, player7])
        
        
        let team1 = Team(teamId: "-99dhjeh3HHD3i9s", teamPIN: 123456, teamName: "Avonmouth FC", teamPostcode: "BS11 8YT", teamImage: UIImage(named: "AFC_icon")!, fixtures: [fixture1, fixture2, fixture3])
        teamList.append(team1)
        
        let team2 = Team(teamId: "-39fjJKDko9dKKD99LLL", teamPIN: 654321, teamName: "Challengers FC", teamPostcode: "BS20 2FF", teamImage: UIImage(named: "AFC_icon")!, fixtures: [])
        teamList.append(team2)
        
    }
    
}
