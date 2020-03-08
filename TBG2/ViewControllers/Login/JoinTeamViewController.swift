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
        loadData()
    }
    
    func loadData() {
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
            
            for team in teams!.team {
                if team.key == tfTeamID.text {
                    print("Found a Match")
                    let result = team.value as! Dictionary<String, Any>
                    let pin = result["pin"] as! Int
                    let stringPin = String(pin)
                    if stringPin == tfTeamPIN.text {
                        print("PIN Matches - Horray!")
                    }
                    else {
                        print("PIN does not match sorry")
                    }
                }
                else {
                    print("No ID Matches")
                }
            }
            
        default:
            playerPosition = ""
        }
        
    }
    
    
    // Defect occuring because I have 1 team in the loop that errors.
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        guard let teamPIN = Int(tfTeamPIN.text!) else { return }
        guard let teamID = tfTeamID.text else { return }
        
        let spinner = UIViewController.displayLoading(withView: self.view)
        
        
        //Validate the Team and PIN before creating accounts etc
        for team in teams!.team {
            if team.key == tfTeamID.text {
                let result = team.value as! Dictionary<String, Any>
                let pin = result["pin"] as! Int
                let stringPin = String(pin)
                if stringPin == tfTeamPIN.text {
                    
                    // Team ID and PIN Match - proceed with creating accounts
                    Auth.auth().createUser(withEmail: playerEmailAddress, password: playerPassword) { [weak self] (user, error) in
                        
                        guard let strongSelf = self else { return }
                        
                        if error == nil {
                            
                            guard let userId = user?.user.uid else { return }
                            
                            Auth.auth().signIn(withEmail: self!.playerEmailAddress, password: self!.playerPassword) { (user, error) in
                                DispatchQueue.main.async {
                                    UIViewController.removeLoading(spinner: spinner)
                                }
                                if error == nil {
                                    
                                    DispatchQueue.main.async {
                                        //Join Team
                                        print("Join Teams")
                                        Helper.postPlayerToTeam(userId: userId, playerFullName: self!.playerFullName, playerEmailAddress: self!.playerEmailAddress, playerDateOfBirth: self!.playerDateOfBirth, playerHouseNumber: self!.playerHouseNumber, playerPostcode: self!.playerPostcode, manager: false, playerManager: false, playerPosition: self!.playerPosition, teamID: teamID, teamPIN: teamPIN)
                                        
                                        DispatchQueue.main.async {
                                            Helper.login()
                                        }
                                        
                                    }
                                    
                                } else if let error = error  {
                                    print(error.localizedDescription)
                                    let alert = Helper.signupError(error: error)
                                    DispatchQueue.main.async {
                                        strongSelf.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                            
                        } else if let error = error {
                            print(error.localizedDescription)
                            let alert = Helper.loginError(error: error)
                            DispatchQueue.main.async {
                                strongSelf.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
                else {
                    //PIN Error
                    let alert = Helper.errorAlert(title: "Incorrect PIN", message: "The PIN supplied is incorrect. Please use the correct PIN")
                    DispatchQueue.main.async {
                        UIViewController.removeLoading(spinner: spinner)
                    }
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                //ID Error
                let alert = Helper.errorAlert(title: "Incorrect ID", message: "The ID supplied is incorrect. Please use the correct ID")
                DispatchQueue.main.async {
                    UIViewController.removeLoading(spinner: spinner)
                }
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    }

}
