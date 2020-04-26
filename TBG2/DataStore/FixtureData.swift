//
//  FixtureData.swift
//  TBG2
//
//  Created by Kris Reid on 18/04/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import Foundation
import FirebaseDatabase


class FixtureModel {
    
    static var collection: DatabaseReference {
        get {
            return Database.database().reference().child("fixtures")
        }
    }
    
    
    var homeFixture: Bool
    var opposition: String
    var date: String
    var time: String
    var postcode: String
    var homeGoals: String
    var awayGoals: String
    var players: Dictionary<String, Any>
    
    //IN THE CODE PASS A SNAPSHOT INTO THE MODEL AND THEN GET BACK THE PARSED VALUES

    init?(_ snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return nil }

        self.homeFixture = value["homeFixture"] as? Bool ?? false
        self.opposition = value["opposition"] as? String ?? ""
        self.date = value["date"] as? String ?? ""
        self.time = value["time"] as? String ?? ""
        self.postcode = value["postcode"] as? String ?? ""
        self.homeGoals = value["homeGoals"] as? String ?? "-"
        self.awayGoals = value["awayGoals"] as? String ?? "-"
        self.players = value["players"] as? Dictionary ?? ["":""]
    }
    
    
    class func postFixture (teamId: String, homeFixture: Bool, opposition: String, date: String, time: String, postcode: String, playerIds: NSMutableArray, managerAvailability: Bool, managerId: String, assistantManagerAvailability: Bool, assistantManagerId: String) {
        
        let fixtureDictionary : [String:Any] =
        [
            "homeFixture": homeFixture,
            "opposition": opposition,
            "date": date,
            "time": time,
            "postcode": postcode,
            "homeGoals": "-",
            "awayGoals": "-",
        ]
        
        let fixtureRef = collection.child(teamId).childByAutoId()
        fixtureRef.setValue(fixtureDictionary)
        let fixtureId = String(fixtureRef.key ?? "")
        
        for playerId in playerIds {
            guard let id = playerId as? String else { return }
            
            //Set the base data regardless of who it is
            let baseData : [String:Any] =
            [
                "availability": "Unknown",
                "goals" : 0,
                "motm" : false
            ]
            let playerData : [String:Any] = [id:baseData]
            let playerRef = collection.child(teamId).child(fixtureId).child("players")
            playerRef.updateChildValues(playerData)
            
            //Set with the manager or assistant as available
            if id == managerId && managerAvailability == true || id == assistantManagerId && assistantManagerAvailability == true {
                
                let baseData : [String:Any] =
                [
                    "availability": "Yes",
                    "goals" : 0,
                    "motm" : false
                ]
                let managerData : [String:Any] = [id:baseData]
                let managerRef = collection.child(teamId).child(fixtureId).child("players")
                managerRef.updateChildValues(managerData)
            }
            //Set with the manager or assistant as not available
            else if id == managerId && managerAvailability == false || id == assistantManagerId && assistantManagerAvailability == false {
                
                let baseData : [String:Any] =
                [
                    "availability": "No",
                    "goals" : 0,
                    "motm" : false
                ]
                let managerData : [String:Any] = [id:baseData]
                let managerRef = collection.child(teamId).child(fixtureId).child("players")
                managerRef.updateChildValues(managerData)
            }
  
        }
        
    }

}