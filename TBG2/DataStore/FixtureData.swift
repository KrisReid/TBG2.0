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
    
    var fixtureId: String
    var homeFixture: Bool
    var opposition: String
    var date: String
    var time: String
    var postcode: String
    var teamGoals: Int
    var oppositionGoals: Int
    var players: Dictionary<String, Any>
    
    
    //IN THE CODE PASS A SNAPSHOT INTO THE MODEL AND THEN GET BACK THE PARSED VALUES
    init?(_ snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return nil }

        self.fixtureId = value["fixtureId"] as? String ?? ""
        self.homeFixture = value["homeFixture"] as? Bool ?? false
        self.opposition = value["opposition"] as? String ?? ""
        self.date = value["date"] as? String ?? ""
        self.time = value["time"] as? String ?? ""
        self.postcode = value["postcode"] as? String ?? ""
        self.teamGoals = value["teamGoals"] as? Int ?? 9999
        self.oppositionGoals = value["oppositionGoals"] as? Int ?? 9999
        self.players = value["players"] as? Dictionary ?? ["":""]
    }
    
//    class func playerFixtureData() -> Dictionary<String, Any> {
//
//    }
    
    
    class func postFixture (teamId: String, homeFixture: Bool, opposition: String, date: String, time: String, postcode: String, playerIds: NSMutableArray, managerAvailability: Bool, managerId: String, assistantManagerAvailability: Bool, assistantManagerId: String) {
        
        let fixtureRef = collection.child(teamId).childByAutoId()
        let newKey = fixtureRef.key
        
        let fixtureDictionary : [String:Any] =
        [
            "fixtureId": newKey as Any,
            "homeFixture": homeFixture,
            "opposition": opposition,
            "date": date,
            "time": time,
            "postcode": postcode,
            "teamGoals": 0,
            "oppositionGoals": 0
        ]
        
        fixtureRef.setValue(fixtureDictionary)
        
        fixtureRef.setValue(fixtureDictionary)
        let fixtureId = String(fixtureRef.key ?? "")

        for playerId in playerIds {
            
            guard let id = playerId as? String else { return }
            
            //get the player name and pictureURL to store in the object
            let playerRef = PlayerModel.collection.child(id)
            let playerRefQuery = playerRef.queryOrderedByKey()
            playerRefQuery.observe(.value) { (snapshot) in
                guard let player = PlayerModel(snapshot) else { return }
                
                //Internal function to add a player
                func playerFixtureData (availability: String) -> Dictionary<String, Any> {
                    let playerFixtureData : [String:Any] =
                    [
                        "availability": availability,
                        "goals" : 0,
                        "motm" : false,
                        "id" : player.id,
                        "fullName": player.fullName,
                        "profilePictureUrl": player.profilePictureUrl?.absoluteString ?? ""
                    ]
                    return playerFixtureData
                }
                
                //Default value of setting the players data
                let data = playerFixtureData(availability: "Unknown")
                let playerData : [String:Any] = [id:data]
                let playerRef = collection.child(teamId).child(fixtureId).child("players")
                playerRef.updateChildValues(playerData)
                
                
                //Set with the manager or assistant as available
                if id == managerId && managerAvailability == true || id == assistantManagerId && assistantManagerAvailability == true {

                    let data = playerFixtureData(availability: "Yes")
                    let managerData : [String:Any] = [id:data]
                    let managerRef = collection.child(teamId).child(fixtureId).child("players")
                    managerRef.updateChildValues(managerData)
                }
                
                    
                //Set with the manager or assistant as not available
                else if id == managerId && managerAvailability == false || id == assistantManagerId && assistantManagerAvailability == false {
                    
                    let data = playerFixtureData(availability: "No")
                    let managerData : [String:Any] = [id:data]
                    let managerRef = collection.child(teamId).child(fixtureId).child("players")
                    managerRef.updateChildValues(managerData)
                }
            }
        }
    }
    
    class func postMotm(teamId: String, fixtureId: String, playerId: String, motm: Bool) {
        let fixtureRef = collection.child(teamId).child(fixtureId).child("players").child(playerId).child("motm")
        fixtureRef.setValue(motm)
    }
    
    class func postOppositionGoals(teamId: String, fixtureId: String, goals: Int) {
        let fixtureRef = collection.child(teamId).child(fixtureId).child("oppositionGoals")
        fixtureRef.setValue(goals)
    }
    
    
    class func postPlayerGoals(teamId: String, fixtureId: String, playerId: String, goal: Bool) {
        
        let fixtureRef = collection.child(teamId).child(fixtureId)
        
        func goalCalculation (currentGoalCount: Int) -> Int {
            var count = currentGoalCount
            if goal {
                count += 1
            } else {
                count -= 1
            }
            return count
        }
        
        fixtureRef.child("players").child(playerId).child("goals").observeSingleEvent(of: .value) { (snapshot) in
//            var updatedGoalValue = snapshot.value as! Int
//            if goal {
//                updatedGoalValue += 1
//            } else {
//                updatedGoalValue -= 1
//            }
//            fixtureRef.child("players").child(playerId).child("goals").setValue(updatedGoalValue)
            
            let updatedGoalValue = goalCalculation(currentGoalCount: snapshot.value as! Int)
            fixtureRef.child("players").child(playerId).child("goals").setValue(updatedGoalValue)
        }
        
        fixtureRef.child("teamGoals").observeSingleEvent(of: .value) { (snapshot) in
//            var updatedTeamGoalValue = snapshot.value as! Int
//            if goal {
//                updatedTeamGoalValue += 1
//            } else {
//                updatedTeamGoalValue -= 1
//            }
//            fixtureRef.child("teamGoals").setValue(updatedTeamGoalValue)
            let updatedTeamGoalValue = goalCalculation(currentGoalCount: snapshot.value as! Int)
            fixtureRef.child("teamGoals").setValue(updatedTeamGoalValue)
        }
    }
    
    class func deleteFixture(teamId: String, fixtureId: String) {
        collection.child(teamId).child(fixtureId).observe(.value) { (snapshot) in
            snapshot.ref.removeValue()
        }
    }

}
