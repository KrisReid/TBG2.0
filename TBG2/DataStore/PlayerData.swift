//
//  PlayerData.swift
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



//class PlayerFixtureModel {
//
//    var id: String
//    var fullName: String
//    var profilePictureUrl: URL?
//    var availability: String
//    var goals: Int
//    var motm: Bool
//
//    init?(_ snapshot: DataSnapshot) {
//        guard let value = snapshot.value as? [String: Any] else { return nil }
//
//        self.id = value["id"] as? String ?? ""
//        self.fullName = value["fullName"] as? String ?? ""
//        self.availability = value["availability"] as? String ?? ""
//        self.goals = value["goals"] as? Int ?? 0
//        self.motm = value["motm"] as? Bool ?? false
//
//        if let profilePicture = value["profilePictureUrl"] as? String {
//           self.profilePictureUrl = URL(string: profilePicture)
//        }
//    }
//}

class PlayerFixtureModel {

    var id: String
    var fullName: String
    var profilePictureUrl: URL?
    var availability: String
    var goals: Int
    var motm: Bool

    init?(_ snapshot: Dictionary<String, Any>) {
        
        guard let value = snapshot as? [String: Any] else { return nil }

        self.id = value["id"] as? String ?? ""
        self.fullName = value["fullName"] as? String ?? ""
        self.availability = value["availability"] as? String ?? ""
        self.goals = value["goals"] as? Int ?? 0
        self.motm = value["motm"] as? Bool ?? false

        if let profilePicture = value["profilePictureUrl"] as? String {
           self.profilePictureUrl = URL(string: profilePicture)
        }
    }
}

class PlayerModel {
    
    static var authCollection: String {
        get {
            return Auth.auth().currentUser?.uid ?? ""
        }
    }
    
    static var collection: DatabaseReference {
        get {
            return Database.database().reference().child("players")
        }
    }
    
    //This is just a way to parse the snapshot
    var id: String
    var fullName: String
    var email: String
    var dateOfBirth: String
    var profilePictureUrl: URL?
    var houseNumber: String
    var postcode: String
    var assistantManager: Bool
    var manager: Bool
    var playerManager: Bool
    var position: String
    var teamId: String
    var gamesTotal: Int
    var motmTotal: Int
    var goalTotal: Int
    
    
    //IN THE CODE PASS A SNAPSHOT INTO THE MODEL AND THEN GET BACK THE PARSED VALUES
    init?(_ snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return nil }
        
        // CHANGE THESE TO GUARD STATEMENTS ONCE VALIDATION ADDED AT LOGIN
        self.id = value["id"] as? String ?? ""
        self.fullName = value["fullName"] as? String ?? ""
        self.email = value["email"] as? String ?? ""
        self.dateOfBirth = value["dateOfBirth"] as? String ?? ""
        self.houseNumber = value["houseNumber"] as? String ?? ""
        self.postcode = value["postcode"] as? String ?? ""
        self.manager = value["manager"] as? Bool ?? false
        self.assistantManager = value["assistantManager"] as? Bool ?? false
        self.playerManager = value["playerManager"] as? Bool ?? false
        self.position = value["position"] as? String ?? ""
        self.teamId = value["teamId"] as? String ?? ""
        self.gamesTotal = value["gamesTotal"] as? Int ?? 0
        self.motmTotal = value["motmTotal"] as? Int ?? 0
        self.goalTotal = value["goalTotal"] as? Int ?? 0
        
        if let profilePicture = value["profilePictureUrl"] as? String {
            self.profilePictureUrl = URL(string: profilePicture)
        }
        
    }
    
    static func getDefaultPlayer() -> DatabaseReference {
       return PlayerModel.collection.child("DefaultPlayerToPull123456789")
    }
    
    
    static func getUser () -> DatabaseReference {
        let uuid = PlayerModel.authCollection
        let user = PlayerModel.collection.child(uuid)
        return user
    }
    
    
    static func postPlayerProfile(profilePicture: UIImage, userId: String, playerFullName: String, playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, assistantManager: Bool, playerManager: Bool, playerPosition: String, teamId: String, teamPIN: Int) {
        
        let imageFolder = Storage.storage().reference().child("player_images")
        if let uploadData = profilePicture.jpegData(compressionQuality: 0.75) {
            
            let UID = NSUUID().uuidString
            
            imageFolder.child("\(UID).jpeg").putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    imageFolder.child("\(UID).jpeg").downloadURL { (url, error) in
                        if let url = url,
                            error == nil {
                            let playerProfilePictureUrl = url.absoluteString

                            postPlayer(userId: userId, playerProfilePictureUrl: playerProfilePictureUrl, playerFullName: playerFullName, playerEmailAddress: playerEmailAddress, playerDateOfBirth: playerDateOfBirth, playerHouseNumber: playerHouseNumber, playerPostcode: playerPostcode, manager: manager, assistantManager: assistantManager, playerManager: playerManager, playerPosition: playerPosition, teamId: teamId, teamPIN: teamPIN)
                        }
                    }
                }
            }
        }
    }
    
    
    static private func postPlayer(userId: String, playerProfilePictureUrl:String, playerFullName: String, playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, assistantManager: Bool, playerManager: Bool, playerPosition: String, teamId: String, teamPIN: Int) {
        
        let playerDictionary : [String:Any] =
        [
            "id": userId,
            "fullName" : playerFullName,
            "profilePictureUrl" : playerProfilePictureUrl,
            "email" : playerEmailAddress,
            "dateOfBirth" : playerDateOfBirth,
            "houseNumber" : playerHouseNumber,
            "postcode" : playerPostcode,
            "manager" : manager,
            "assistantManager" : assistantManager,
            "playerManager" : playerManager,
            "position" : playerPosition,
            "teamId" : teamId,
            "goalTotal" : 0,
            "motmTotal" : 0,
            "gamesTotal": 0
        ]
        
        collection.child(userId).updateChildValues(playerDictionary)
        TeamModel.collection.child(teamId).child("players").child(userId).updateChildValues(playerDictionary)
    }
    
    class func postMotm(playerId: String, motm: Bool) {
        let playerRef = collection.child(playerId).child("motmTotal")
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
    
    class func postPlayerGoals(playerId: String, goal: Int) {
        let playerRef = collection.child(playerId).child("goalTotal")
        playerRef.observeSingleEvent(of: .value) { (snapshot) in
            let updatedGoalValue = Helper.goalCalculation(currentGoalCount: snapshot.value as! Int, goal: goal)
            playerRef.setValue(updatedGoalValue)
        }
    }
    
    class func postGamePlayed(playerId: String, game: Bool) {
        let playerRef = collection.child(playerId).child("gamesTotal")
        playerRef.observeSingleEvent(of: .value) { (snapshot) in
            var updatedGamesValue = snapshot.value as! Int
            if game {
                updatedGamesValue += 1
            } else {
                updatedGamesValue -= 1
            }
            playerRef.setValue(updatedGamesValue)
        }
    }
    
}
