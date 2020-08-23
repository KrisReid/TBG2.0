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
        self.teamGoals = value["teamGoals"] as? Int ?? 0
        self.oppositionGoals = value["oppositionGoals"] as? Int ?? 0
        self.players = value["players"] as? Dictionary ?? ["":""]
    }
    
    
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
        let fixtureId = String(fixtureRef.key ?? "")

        for playerId in playerIds {
            
            guard let id = playerId as? String else { return }
            
            //get the player name and pictureURL to store in the object
            let playerRef = PlayerModel.collection.child(id)
            let playerRefQuery = playerRef.queryOrderedByKey()
            playerRefQuery.observeSingleEvent(of: .value) { (snapshot) in
//            playerRefQuery.observe(.value) { (snapshot) in
                guard let player = PlayerModel(snapshot) else { return }
                
                //Internal function to add a player
                func playerFixtureData (availability: String) -> Dictionary<String, Any> {
                    let playerFixtureData : [String:Any] =
                    [
                        "availability": availability,
                        "credit": 0,
                        "debit": 0,
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
        let motmRef = collection.child(teamId).child(fixtureId).child("players").child(playerId).child("motm")
        motmRef.setValue(motm)
    }
    
    
    class func postOppositionGoals(teamId: String, fixtureId: String, goals: Int) {
        let fixtureRef = collection.child(teamId).child(fixtureId).child("oppositionGoals")
        fixtureRef.setValue(goals)
    }
    
    
    class func postPlayerGoals(teamId: String, fixtureId: String, playerId: String, goal: Int) {
        let fixtureRef = collection.child(teamId).child(fixtureId)
        
        fixtureRef.child("players").child(playerId).child("goals").observeSingleEvent(of: .value) { (snapshot) in
            let updatedGoalValue = Helper.goalCalculation(currentGoalCount: snapshot.value as! Int, goal: goal)
            fixtureRef.child("players").child(playerId).child("goals").setValue(updatedGoalValue)
        }
        
        fixtureRef.child("teamGoals").observeSingleEvent(of: .value) { (snapshot) in
            let updatedTeamGoalValue = Helper.goalCalculation(currentGoalCount: snapshot.value as! Int, goal: goal)
            fixtureRef.child("teamGoals").setValue(updatedTeamGoalValue)
        }
    }
    
    class func postPlayerAvailability(teamId: String, fixtureId: String, playerId: String, availability: Bool) {
        
        let playerRef = collection.child(teamId).child(fixtureId).child("players").child(playerId)
        
        if availability {
            playerRef.child("availability").setValue("Yes")
            //Update the players debit for the game
            postPlayerDebit(teamId: teamId, fixtureId: fixtureId, playerId: playerId, debitValue: 4)
        } else {
            playerRef.child("availability").setValue("No")
            playerRef.child("debit").observeSingleEvent(of: .value) { (snapshot) in
                let debit = snapshot.value as! Int
                if debit != 0 {
                    //Update the players debit for the game
                    postPlayerDebit(teamId: teamId, fixtureId: fixtureId, playerId: playerId, debitValue: 0)
                }
            }
        }
    }
    
    class func postPlayerDebit(teamId: String, fixtureId: String, playerId: String, debitValue: Double) {
        print("333333333333: \(debitValue)")
        collection.child(teamId).child(fixtureId).child("players").child(playerId).child("debit").setValue(debitValue)
    }
    
    
    class func deleteFixture(teamId: String, fixtureId: String) {
        
        collection.child(teamId).child(fixtureId).observeSingleEvent(of: .value) { (snapshot) in

            guard let fixture = FixtureModel(snapshot) else { return }
            
            for player in fixture.players {
                guard let playerFixture = PlayerFixtureModel(player.value as! Dictionary<String, Any>) else { return }
                
                //Adjust all of the players Goals
                if playerFixture.goals >= 1 {
                    // turn the gaols negative
                    let negativeGoals = playerFixture.goals - (playerFixture.goals * 2)
                    PlayerModel.postPlayerGoals(playerId: playerFixture.id, goal: negativeGoals)
                    TeamModel.postPlayerGoals(teamId: teamId, playerId: playerFixture.id, goal: negativeGoals)
                }
                //Adjust the MOTM awards
                if playerFixture.motm {
                    PlayerModel.postMotm(playerId: playerFixture.id, motm: false)
                    TeamModel.postMotm(teamId: teamId, playerId: playerFixture.id, motm: false)
                }
                //Adjust the games played
                if playerFixture.availability == "Yes" {
                    PlayerModel.postGamePlayed(playerId: playerFixture.id, game: false)
                    TeamModel.postGamePlayed(teamId: teamId, playerId: playerFixture.id, game: false)
                }
            }
            snapshot.ref.removeValue()
        }
    }

}
