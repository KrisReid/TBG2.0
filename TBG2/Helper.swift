//
//  Helper.swift
//  TBG2
//
//  Created by Kris Reid on 09/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class Helper {
    
    class func errorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        return alert
    }
    
    
    class func login() {
        let tabController = UITabBarController()

        let teamStoryboard = UIStoryboard(name: "Team", bundle: nil)
        let fixturesStoryboard = UIStoryboard(name: "Fixtures", bundle: nil)
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)

        let teamVC = teamStoryboard.instantiateViewController(withIdentifier: "Team") as! TeamViewController
        let fixturesVC = fixturesStoryboard.instantiateViewController(withIdentifier: "Fixtures") as! FixturesViewController

        let settingsVC = settingsStoryboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController


        let vcData: [(UIViewController, UIImage, UIImage)] = [

            (teamVC, UIImage(named: "team_tab_icon")!, UIImage(named: "team_selected_tab_icon")!),
            (fixturesVC, UIImage(named: "fixtures_tab_icon")!, UIImage(named: "fixtures_selected_tab_icon")!),
            (settingsVC, UIImage(named: "settings_tab_icon")!, UIImage(named: "settings_selected_tab_icon")!)

        ]

        let vcs = vcData.map { (vc, defaultImage, selectedImage) -> UINavigationController in

            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem.image = defaultImage
            nav.tabBarItem.selectedImage = selectedImage
            return nav
        }

        tabController.viewControllers = vcs
        tabController.tabBar.isTranslucent = false
//        tabController.delegate = tabBarDelegate

        if let items = tabController.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                if let selectedImage = item.selectedImage {
                    item.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }

        UINavigationBar.appearance().backgroundColor = UIColor.white
        
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            guard let window = sd.window else { return }
            window.rootViewController = tabController
        }
    }
    
    
    class func logout() {
        do {
            try Auth.auth().signOut()
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                guard let window = sd.window else { return }
                window.rootViewController = loginViewController
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    class func signupError(error: Error) -> UIAlertController {
        let rawErrorCode = error._code
        var errorTitle: String = "Signup Error"
        var errorMessage: String = "There was a problem signing up"
        if let errorCode = AuthErrorCode(rawValue: rawErrorCode) {
            switch errorCode {
            case .emailAlreadyInUse:
                errorTitle = "Email in use"
                errorMessage = "The email address you provided is already in use"
            case .invalidEmail:
                errorTitle = "Invalid Email"
                errorMessage = "Please enter a valid email address"
            case .weakPassword:
                errorTitle = "Weak password provided"
                errorMessage = "Please enter a stronger password"
            default:
                break
            }
        }
        return Helper.errorAlert(title: errorTitle, message: errorMessage)
    }
    
    
    class func loginError(error: Error) -> UIAlertController {
        let rawErrorCode = error._code
        var errorTitle: String = "Login Error"
        var errorMessage: String = "There was a problem loggin in"
        if let errorCode = AuthErrorCode(rawValue: rawErrorCode) {
            switch errorCode {
            case .wrongPassword:
                errorTitle = "Incorrect Password"
                errorMessage = "The password provided is incorrect"
            case .invalidEmail:
                errorTitle = "Invalid Email"
                errorMessage = "Please enter a valid email address"
            default:
                break
            }
        }
        return Helper.errorAlert(title: errorTitle, message: errorMessage)
    }
    
    
    class func postNewTeam(userId: String, playerFullName: String,playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, playerManager: Bool, playerPosition: String, teamName: String, teamPIN: Int, teamPostcode: String) {
        
        let teamRef = Database.database().reference().child("teams").childByAutoId()
        let newKey = teamRef.key
        let TeamDictionary : [String:Any] = ["name": teamName, "pin": teamPIN, "postcode":teamPostcode, "id": newKey as Any]
        teamRef.setValue(TeamDictionary)
        
        DispatchQueue.main.async {
            postPlayerToTeam(userId: userId, playerFullName: playerFullName, playerEmailAddress: playerEmailAddress, playerDateOfBirth: playerDateOfBirth, playerHouseNumber: playerHouseNumber, playerPostcode: playerPostcode, manager: true, playerManager: playerManager, playerPosition: playerPosition, teamID: newKey!, teamPIN: teamPIN)
        }
    }
    
    
    class func postPlayerToTeam(userId: String, playerFullName: String,playerEmailAddress: String, playerDateOfBirth: String, playerHouseNumber: String, playerPostcode: String, manager: Bool, playerManager: Bool, playerPosition: String, teamID: String, teamPIN: Int) {
        
        let playerDictionary : [String:Any] =
        [
            "id": userId,
            "fullName" : playerFullName,
//            "imageURL" : self!.playerProfilePicture!,
            "email" : playerEmailAddress,
            "dateOfBirth" : playerDateOfBirth,
            "houseNumber" : playerHouseNumber,
            "postcode" : playerPostcode,
            "manager" : false,
            "playerManager" : false,
            "position" : playerPosition
        ]
    Database.database().reference().child("teams").child(teamID).child("players").child(userId).updateChildValues(playerDictionary)
    }
    
    
    class func getTeams() -> [DataSnapshot] {
        var teams : [DataSnapshot] = []

        Database.database().reference().child("teams").observe(.childAdded, with: { (snapshot) in
            teams.append(snapshot)
        })
        
        return teams
    }
    
    
}
