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
    

    //IN THE CODE PASS A SNAPSHOT INTO THE MODEL AND THEN GET BACK THE PARSED VALUES
    
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
    
    
    static func postNewTeam(userId: String, playerProfilePicture: UIImage, playerFullName: String,playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, assistantManager: Bool, playerManager: Bool, playerPosition: String, teamName: String, teamPIN: Int, teamPostcode: String, teamCrest: UIImage) {
        
        
        let imageFolder = Storage.storage().reference().child("crest_images")
        if let uploadData = teamCrest.jpegData(compressionQuality: 0.75) {
           
            imageFolder.child("\(NSUUID().uuidString).jpeg").putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let teamRef = TeamModel.collection.childByAutoId()
                    let newKey = teamRef.key
                    let TeamDictionary : [String:Any] =
                        [
                            "crest": String((metadata?.path)!),
                            "name": teamName,
                            "pin": teamPIN,
                            "postcode":teamPostcode,
                            "id": newKey as Any
                        ]
                     teamRef.setValue(TeamDictionary)
                    
                     DispatchQueue.main.async {

                        PlayerModel.postPlayerProfile(profilePicture: playerProfilePicture, userId: userId, playerFullName: playerFullName, playerEmailAddress: playerEmailAddress, playerDateOfBirth: playerDateOfBirth, playerHouseNumber: playerHouseNumber, playerPostcode: playerPostcode, manager: manager, assistantManager: assistantManager, playerManager: playerManager, playerPosition: playerPosition, teamId: newKey!, teamPIN: teamPIN)

                     }
                }
            }
        }
    }

}
