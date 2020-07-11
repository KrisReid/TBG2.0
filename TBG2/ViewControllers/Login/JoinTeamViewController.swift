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
import FirebaseStorage

class JoinTeamViewController: UIViewController {
    
    @IBOutlet weak var tfTeamID: UITextField!
    @IBOutlet weak var tfTeamPIN: UITextField!
    @IBOutlet weak var scPlayerPosition: UISegmentedControl!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var playerProfilePicture: UIImageView? = nil
    var playerFullName: String = ""
    var playerEmailAddress: String = ""
    var playerPassword: String = ""
    var playerDateOfBirth: String = ""
    var playerHouseNumber: String = ""
    var playerPostcode: String = ""
    var playerPosition: String = ""
    
    var match: Bool = false
    
    var teams: TeamModel?
    var colour = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Accessability Identifiers
        setupAccessibilityAndLocalisation()

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
        getTeams()
    }

    private func setupAccessibilityAndLocalisation() {
        tfTeamID.accessibilityIdentifier = AccessabilityIdentifier.JoinTeamId.rawValue
        tfTeamPIN.accessibilityIdentifier = AccessabilityIdentifier.joinTeamPIN.rawValue
        btnSubmit.accessibilityIdentifier = AccessabilityIdentifier.joinTeamSubmitButton.rawValue
    }
    
    func getTeams() {
        let teamRef = TeamModel.collection
        let spinner = UIViewController.displayLoading(withView: self.view)
        teamRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            UIViewController.removeLoading(spinner: spinner)
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
    
    func teamIDPINValidation() {
        let validaion = DispatchQueue(label: "validation")
        validaion.sync {
            guard let teams = teams?.teams else { return }
            for team in teams {
                if team.key == tfTeamID.text {
                    let result = team.value as! Dictionary<String, Any>
                    let pin = result["pin"] as! Int
                    if String(pin) == tfTeamPIN.text {
                        // ID and PIN Match
                        self.match = true
                    }
                }
            }
        }
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        let teamCheck = DispatchQueue(label: "team_check")
        let authenticate = DispatchQueue(label: "authenticate")
        
        teamCheck.sync {
            self.teamIDPINValidation()
        }
        
        authenticate.sync {
            if self.match {
                
                guard let teamPIN = Int(tfTeamPIN.text!) else { return }
                guard let teamId = tfTeamID.text else { return }
                guard let profilePicture = playerProfilePicture?.image else { return }

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
                                PlayerModel.postPlayerProfile(profilePicture: profilePicture, userId: userId, playerFullName: self!.playerFullName, playerEmailAddress: self!.playerEmailAddress, playerDateOfBirth: self!.playerDateOfBirth, playerHouseNumber: self!.playerHouseNumber, playerPostcode: self!.playerPostcode, manager: false, assistantManager: false, playerManager: false, playerPosition: self!.playerPosition, teamId: teamId, teamPIN: teamPIN)
                                
                                DispatchQueue.main.async {
                                    Helper.login()
                                }
                            } else if let error = error  {
                                let alert = Helper.signupError(error: error)
                                DispatchQueue.main.async {
                                    strongSelf.present(alert, animated: true, completion: nil)
                                    UIViewController.removeLoading(spinner: spinner)
                                }
                            }
                        }
                    } else if let error = error {
                        let alert = Helper.loginError(error: error)
                        DispatchQueue.main.async {
                            strongSelf.present(alert, animated: true, completion: nil)
                            UIViewController.removeLoading(spinner: spinner)
                        }
                    }
                }
            } else {
                let alert = Helper.errorAlert(title: "Team ID/PIN Error", message: "There has been an issue with either the PIN or ID ... Please try again")
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}
