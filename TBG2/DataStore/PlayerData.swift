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

struct Player {
    var id: Int
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
        
        let player1 = Player(id: 1, playerImage: UIImage(named: "player1")!, playerName: "John Carrick", playerAge: 24, playerPostion: "goalkeeper")
        playerList.append(player1)
        goalkeeperList.append(player1)
        
        let player2 = Player(id: 2, playerImage: UIImage(named: "player2")!, playerName: "Dwayne Jenas", playerAge: 27, playerPostion: "defender")
        playerList.append(player2)
        defenderList.append(player2)
        
        let player3 = Player(id: 3, playerImage: UIImage(named: "player1")!, playerName: "Mike Cole", playerAge: 19, playerPostion: "defender")
        playerList.append(player3)
        defenderList.append(player3)
        
        let player4 = Player(id: 4, playerImage: UIImage(named: "player1")!, playerName: "Dean Reid", playerAge: 16, playerPostion: "midfielder")
        playerList.append(player4)
        midfielderList.append(player4)
        
        let player5 = Player(id: 5, playerImage: UIImage(named: "player2")!, playerName: "Dean Reid", playerAge: 22, playerPostion: "midfielder")
        playerList.append(player5)
        midfielderList.append(player5)
        
        let player6 = Player(id: 6, playerImage: UIImage(named: "player2")!, playerName: "Dean Reid", playerAge: 22, playerPostion: "midfielder")
        playerList.append(player6)
        midfielderList.append(player6)
        
        let player7 = Player(id: 7, playerImage: UIImage(named: "player1")!, playerName: "Dean Reid", playerAge: 30, playerPostion: "striker")
        playerList.append(player7)
        strikerList.append(player7)
        
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
    var manager: Bool
    var playerManager: Bool
    var position: String
    var teamId: String

    
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
        self.playerManager = value["playerManager"] as? Bool ?? false
        self.position = value["position"] as? String ?? ""
        self.teamId = value["teamId"] as? String ?? ""
        
        if let profilePicture = value["profilePictureUrl"] as? String {
            self.profilePictureUrl = URL(string: profilePicture)
        }
        
    }
    
    
    static func getUser () -> DatabaseReference {
        let uuid = PlayerModel.authCollection
        let user = PlayerModel.collection.child(uuid)
        return user
    }
    
    
    static func postPlayerProfile(profilePicture: UIImage, userId: String, playerFullName: String, playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, playerManager: Bool, playerPosition: String, teamId: String, teamPIN: Int) {
        
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

                            postPlayer(userId: userId, playerProfilePictureUrl: playerProfilePictureUrl, playerFullName: playerFullName, playerEmailAddress: playerEmailAddress, playerDateOfBirth: playerDateOfBirth, playerHouseNumber: playerHouseNumber, playerPostcode: playerPostcode, manager: manager, playerManager: playerManager, playerPosition: playerPosition, teamId: teamId, teamPIN: teamPIN)
                        }
                    }
                }
            }
        }
    }
    
    
    static private func postPlayer(userId: String, playerProfilePictureUrl:String, playerFullName: String, playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, playerManager: Bool, playerPosition: String, teamId: String, teamPIN: Int) {
        
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
            "playerManager" : playerManager,
            "position" : playerPosition,
            "teamId" : teamId
        ]
        
        collection.child(userId).updateChildValues(playerDictionary)
        TeamModel.collection.child(teamId).child("players").child(userId).updateChildValues(playerDictionary)
    }
    

}

