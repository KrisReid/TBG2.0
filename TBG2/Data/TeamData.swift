//
//  TeamData.swift
//  TBG2
//
//  Created by Kris Reid on 17/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit

struct Team {
    var teamName: String
    var teamPostcode: String
    var teamImage: UIImage
}

class TeamModel {
    
    var teamList: [Team] = [Team]()
    
    init() {
        
        let team1 = Team(teamName: "Avonmouth FC", teamPostcode: "BS11 8YT", teamImage: UIImage(named: "AFC_icon")!)
        teamList.append(team1)
        
        let team2 = Team(teamName: "Challengers FC", teamPostcode: "BS20 2FF", teamImage: UIImage(named: "AFC_icon")!)
        teamList.append(team2)
        
    }
    
    
}