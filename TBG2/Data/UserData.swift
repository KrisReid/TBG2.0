//
//  UserData.swift
//  TBG2
//
//  Created by Kris Reid on 08/03/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth



//class UserModel {
//    static var collection: DatabaseReference {
//        get {
//            return Database.database().reference().child("teams").child()
//        }
//    }
//    
//    var keys: Dictionary<String, Any>.Keys
////    var name: String = ""
////    var pin: Int = 000000
////    var postcode: String = ""
//    
//    init?(_ snapshot: DataSnapshot) {
//        guard let value = snapshot.value as? [String: Any] else { return nil }
//        
//        self.keys = value.keys
//        print(keys)
//        
//        
////        self.name = value["name"] as! String
////        self.pin = value["pin"] as! Int
////        self.postcode = value["postcode"] as! String
//    }
//}
