//
//  TeamData.swift
//  TBG2
//
//  Created by Kris Reid on 17/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class TeamModel {
    
    static var collection: DatabaseReference {
        get {
            return Database.database().reference().child("teams")
        }
    }
    
    var keys: Dictionary<String, Any>.Keys
    var teams: Dictionary<String, Any>
    
    var crest: URL?
    var id: String = ""
    var name: String = ""
    var pin: Int = 000000
    var postcode: String = ""
    
    
    init?(_ snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return nil }
        
        self.keys = value.keys
        self.teams = value
        
        self.id = value["id"] as? String ?? ""
        self.name = value["name"] as? String ?? ""
        self.pin = value["pin"] as? Int ?? 000000
        self.postcode = value["postcode"] as? String ?? ""
        
        if let crest = value["crest"] as? String {
            self.crest = URL(string: crest)
        }
    }
    
    
    static func getTeamPlayers (teamId: String) -> DatabaseReference {
        let players = collection.child(teamId).child("players")
        return players
    }
    
    
    static func postTeamCrest(userId: String, playerProfilePicture: UIImage, playerFullName: String,playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, assistantManager: Bool, playerPosition: String, teamName: String, teamPIN: Int, teamPostcode: String, teamCrest: UIImage) {
        
        let imageFolder = Storage.storage().reference().child("crest_images")
        if let uploadData = teamCrest.jpegData(compressionQuality: 0.75) {
            
            let UID = NSUUID().uuidString
            
            imageFolder.child("\(UID).jpeg").putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    imageFolder.child("\(UID).jpeg").downloadURL { (url, error) in
                        if let url = url,
                            error == nil {
                            let teamCrestUrl = url.absoluteString
                            
                            postTeam(userId: userId, playerProfilePicture: playerProfilePicture, playerFullName: playerFullName,playerEmailAddress: playerEmailAddress, playerDateOfBirth: playerDateOfBirth, playerHouseNumber: playerHouseNumber, playerPostcode: playerPostcode, manager: manager, assistantManager: assistantManager, playerPosition: playerPosition, teamName: teamName, teamPIN: teamPIN, teamPostcode: teamPostcode, teamCrestUrl: teamCrestUrl)
                        }
                    }
                }
            }
        }
    }
    
    private static func postTeam(userId: String, playerProfilePicture: UIImage, playerFullName: String,playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, assistantManager: Bool, playerPosition: String, teamName: String, teamPIN: Int, teamPostcode: String, teamCrestUrl: String) {
        
        let teamRef = TeamModel.collection.childByAutoId()
        let newKey = teamRef.key
        let TeamDictionary : [String:Any] =
            [
                "crest": teamCrestUrl,
                "name": teamName,
                "pin": teamPIN,
                "postcode":teamPostcode,
                "id": newKey as Any
            ]
         teamRef.setValue(TeamDictionary)
        
         DispatchQueue.main.async {

            PlayerModel.postPlayerProfile(profilePicture: playerProfilePicture, userId: userId, playerFullName: playerFullName, playerEmailAddress: playerEmailAddress, playerDateOfBirth: playerDateOfBirth, playerHouseNumber: playerHouseNumber, playerPostcode: playerPostcode, manager: manager, assistantManager: assistantManager, playerPosition: playerPosition, teamId: newKey!, teamPIN: teamPIN)
         }
    }
    
    class func postTeamPIN(teamId: String, teamPIN: Int) {
        let pinRef = collection.child(teamId).child("pin")
        pinRef.setValue(teamPIN)
    }
    
    class func postMotm(teamId: String, playerId: String, motm: Bool) {
        let playerRef = collection.child(teamId).child("players").child(playerId).child("motmTotal")
        playerRef.observeSingleEvent(of: .value) { (snapshot) in
            var updatedMotmValue = snapshot.value as! Int
            if motm {
                updatedMotmValue += 1
            } else {
                updatedMotmValue -= 1
            }
            playerRef.setValue(updatedMotmValue)
        }
    }
    
    class func postPlayerGoals(teamId: String, playerId: String, goal: Int) {
        let playerRef = collection.child(teamId).child("players").child(playerId).child("goalTotal")
        playerRef.observeSingleEvent(of: .value) { (snapshot) in
            let updatedGoalValue = Helper.goalCalculation(currentGoalCount: snapshot.value as! Int, goal: goal)
            playerRef.setValue(updatedGoalValue)
        }
    }
    
    class func postGamePlayed(teamId: String, playerId: String, game: Bool) {
        let playerRef = collection.child(teamId).child("players").child(playerId).child("gamesTotal")
        playerRef.observeSingleEvent(of: .value) { (snapshot) in
            var updatedGameValue = snapshot.value as! Int
            if game {
                updatedGameValue += 1
            } else {
                updatedGameValue -= 1
            }
            playerRef.setValue(updatedGameValue)
        }
    }
    
    class func postPlayersManagerialStatus (teamId: String, playerId: String, managerStatus: Bool, assistantStatus: Bool) {
        let managerStatusRef = collection.child(teamId).child("players").child(playerId).child("manager")
        managerStatusRef.setValue(managerStatus)
        let assistantStatusRef = collection.child(teamId).child("players").child(playerId).child("assistantManager")
        assistantStatusRef.setValue(assistantStatus)
        
    }

}
