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
    
//    var id: String
//    var homeFixture: Bool
//    var opposition: String
//    var date: String
//    var time: String
//    var postcode: String
//    var homeGoals: String
//    var awayGoals: String
//
//
//    init?(_ snapshot: DataSnapshot) {
//        guard let value = snapshot.value as? [String: Any] else { return nil }
//
//        self.id = value["id"] as? String ?? ""
//        self.homeFixture = value["homeFixture"] as? Bool ?? false
//        self.opposition = value["opposition"] as? String ?? ""
//        self.date = value["date"] as? String ?? ""
//        self.time = value["time"] as? String ?? ""
//        self.postcode = value["postcode"] as? String ?? ""
//        self.homeGoals = value["homeGoals"] as? String ?? "-"
//        self.awayGoals = value["awayGoals"] as? String ?? "-"
//
//    }
    
    
    class func postFixture (teamId: String, homeFixture: Bool, opposition: String, date: String, time: String, postcode: String) {
        
        let fixtureDictionary : [String:Any] =
        [
            "homeFixture": homeFixture,
            "opposition": opposition,
            "date": date,
            "time": time,
            "postcode": postcode,
            "homeGoals": "-",
            "awayGoals": "-"
        ]
        
        let fixtureRef = collection.child(teamId).childByAutoId()
        fixtureRef.setValue(fixtureDictionary)
    }
    

}
