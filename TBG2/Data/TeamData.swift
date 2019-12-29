//
//  TeamData.swift
//  TBG2
//
//  Created by Kris Reid on 17/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit


struct Fixture {
    var time: String
    var date: String
    var opposition: String
    var hosts: String
    var homeFixture: Bool
    var venue: String
    var result: String
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
        
        let fixture1 = Fixture(time: "15:00", date: "20-10-2019", opposition: "Challengers FC", hosts: "Avonmouth FC", homeFixture: true, venue: "Old place", result: "4-2")
        let fixture2 = Fixture(time: "17:00", date: "27-10-2019", opposition: "Bolltox FC", hosts: "Avonmouth FC", homeFixture: true, venue: "Old place", result: "5-0")
        let fixture3 = Fixture(time: "15:00", date: "06-11-2019", opposition: "Assticit FC", hosts: "Avonmouth FC", homeFixture: false, venue: "Old place", result: "- - -")
        
        let team1 = Team(teamId: "-99dhjeh3HHD3i9s", teamPIN: 123456, teamName: "Avonmouth FC", teamPostcode: "BS11 8YT", teamImage: UIImage(named: "AFC_icon")!, fixtures: [fixture1, fixture2, fixture3])
        teamList.append(team1)
        
        let team2 = Team(teamId: "-39fjJKDko9dKKD99LLL", teamPIN: 654321, teamName: "Challengers FC", teamPostcode: "BS20 2FF", teamImage: UIImage(named: "AFC_icon")!, fixtures: [])
        teamList.append(team2)
        
    }
    
}
