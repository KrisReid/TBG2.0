//
//  TokenGeneration.swift
//  TBG2
//
//  Created by Kris Reid on 16/10/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseMessaging

class TokenGeneration: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                self.setPlayerToken(token: token)
            }
        }
    }


    func setPlayerToken(token: String) {
        Database.database().reference().child("players").queryOrdered(byChild: "email").queryEqual(toValue: Auth.auth().currentUser?.email).observe(.childAdded) { (snapshot) in
            
            //CHANGE THIS TO USE A SAFE MODEL
            if let Playerdictionary = snapshot.value as? [String:Any] {
                if let currentToken = Playerdictionary["activeToken"] as? String {
                        
                    // Update the Players token if applicable
                    if token == currentToken {
                        print("Token was not updated in the DB as it matches")
                    } else {
                        // Update the new token to replace the old for the Player
                        snapshot.ref.updateChildValues(["activeToken":token])
                        Database.database().reference().child("players").removeAllObservers()
                    }
                }
            }
        }
    }

}
