//
//  JoinTeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 25/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class JoinTeamViewController: UIViewController {
    
    @IBOutlet weak var tfTeamID: UITextField!
    @IBOutlet weak var tfTeamPIN: UITextField!
    @IBOutlet weak var scPlayerPosition: UISegmentedControl!
    
    var playerProfilePicture: UIImageView? = nil
    var playerFullName: String = ""
    var playerEmailAddress: String = ""
    var playerPassword: String = ""
    var playerDateOfBirth: String = ""
    var playerHouseNumber: String = ""
    var playerPostcode: String = ""
    var playerPosition: String = ""
    
    var teams: TeamModel?
    
    var colour = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Keyboard Dismissal
        self.setupHideKeyboardOnTap()
         
        //TextFields
        tfTeamID.underlined(colour: colour.white.cgColor)
        tfTeamPIN.underlined(colour: colour.white.cgColor)
        tfTeamID.whitePlaceholderText(text: "Team ID")
        tfTeamPIN.whitePlaceholderText(text: "Team PIN")
         
        //Segmented Control
        scPlayerPosition.defaultSegmentedControlFormat(backgroundColour: UIColor.clear)

        //Load Data
        loadTeams()
    }
    
    func loadTeams() {
        let teamRef = TeamModel.collection
        teamRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let teams = TeamModel(snapshot) else { return }
            strongSelf.teams = teams
        }
    }
    
    @IBAction func scPlayerPositionTapped(_ sender: Any) {
        switch scPlayerPosition.selectedSegmentIndex {
        case 0:
            playerPosition = "Goalkeeper"
        case 1:
            playerPosition = "Defender"
        case 2:
            playerPosition = "Midfielder"
        case 3:
            playerPosition = "Striker"
        default:
            playerPosition = ""
        }
    }
    
    
    func check() -> Bool {
        guard let teames = teams?.team else { return false }
        for team in teames {
            if team.key == tfTeamID.text {
                let result = team.value as! Dictionary<String, Any>
                let pin = result["pin"] as! Int
                let stringPin = String(pin)
                if stringPin == tfTeamPIN.text {
                    // ID and PIN Match so return true
                    return true
                }
                else {
                    //PIN Error
                    let alert = Helper.errorAlert(title: "Incorrect PIN", message: "The PIN supplied is incorrect. Please use the correct PIN")
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                //ID Error
                let alert = Helper.errorAlert(title: "Incorrect ID", message: "The ID supplied is incorrect. Please use the correct ID")
                self.present(alert, animated: true, completion: nil)
            }
        }
        // Retrun false if nothing found in the loop
        return false
    }

    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        //Validate the Team and PIN before creating accounts etc
        let team = self.check()
        if team {
            guard let teamPIN = Int(tfTeamPIN.text!) else { return }
            guard let teamID = tfTeamID.text else { return }
            
            let spinner = UIViewController.displayLoading(withView: self.view)
            
            // Create the Account in Firebase
            Auth.auth().createUser(withEmail: playerEmailAddress, password: playerPassword) { [weak self] (user, error) in

                guard let strongSelf = self else { return }

                if error == nil {
                    guard let userId = user?.user.uid else { return }
                    
                    // Sign in with Firebase
                    Auth.auth().signIn(withEmail: self!.playerEmailAddress, password: self!.playerPassword) { (user, error) in
                        DispatchQueue.main.async {
                            UIViewController.removeLoading(spinner: spinner)
                        }
                        if error == nil {
                            DispatchQueue.main.async {
                                //Join Team
                                Helper.postPlayerToTeam(userId: userId, playerFullName: self!.playerFullName, playerEmailAddress: self!.playerEmailAddress, playerDateOfBirth: self!.playerDateOfBirth, playerHouseNumber: self!.playerHouseNumber, playerPostcode: self!.playerPostcode, manager: false, playerManager: false, playerPosition: self!.playerPosition, teamID: teamID, teamPIN: teamPIN)

                                DispatchQueue.main.async {
                                    Helper.login()
                                }
                            }
                        } else if let error = error  {
                            // Signup Error
                            print(error.localizedDescription)
                            let alert = Helper.signupError(error: error)
                            DispatchQueue.main.async {
                                strongSelf.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                } else if let error = error {
                    // Login Error
                    print(error.localizedDescription)
                    let alert = Helper.loginError(error: error)
                    DispatchQueue.main.async {
                        strongSelf.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        else {
            //Do Nothing
            print("Do Nothing")
        }
    }


}
