//
//  CreateTeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 23/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseAuth

class CreateTeamViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnTeamCrest: UIButton!
    @IBOutlet weak var tfTeamName: UITextField!
    @IBOutlet weak var tfTeamPIN: UITextField!
    @IBOutlet weak var tfTeamPostcode: UITextField!
    @IBOutlet weak var scPlayerManager: UISegmentedControl!
    @IBOutlet weak var scPlayerPosition: UISegmentedControl!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var playerProfilePicture: UIImageView? = nil
    var playerFullName: String = ""
    var playerEmailAddress: String = ""
    var playerPassword: String = ""
    var playerDateOfBirth: String = ""
    var playerHouseNumber: String = ""
    var playerPostcode: String = ""
    var playerManager: Bool = false
    var playerPosition: String = ""

    var colour = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Keyboard Dismissal
        self.setupHideKeyboardOnTap()
        
        //Buttons
        btnTeamCrest.circle(colour: colour.white.cgColor)
        
        //TextFields
        tfTeamName.underlined(colour: colour.white.cgColor)
        tfTeamPIN.underlined(colour: colour.white.cgColor)
        tfTeamPostcode.underlined(colour: colour.white.cgColor)
        tfTeamName.whitePlaceholderText(text: "Team Name")
        tfTeamPIN.whitePlaceholderText(text: "Team PIN")
        tfTeamPostcode.whitePlaceholderText(text: "Team Postcode")
        
        //Segmented Control
        scPlayerManager.defaultSegmentedControlFormat(backgroundColour: UIColor.clear)
        scPlayerPosition.defaultSegmentedControlFormat(backgroundColour: UIColor.clear)
        
    }
    
    @IBAction func btnTeamCrestTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //WHY CAN THIS NOT BE A SHARED FUNCTION
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        btnTeamCrest.setImage(image , for: UIControl.State.normal)
        btnTeamCrest.setTitle("",for: .normal)
    }
    
    
    @IBAction func scPlayerManagerTapped(_ sender: Any) {
        if scPlayerManager.selectedSegmentIndex == 1 {
            playerManager = true
            scPlayerPosition.isHidden = false
        } else {
            playerManager = false
            scPlayerPosition.isHidden = true
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
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        guard let teamName = tfTeamName.text else { return }
        guard let teamCrest = btnTeamCrest.imageView else { return }
        guard let teamPIN = tfTeamPIN.text else { return }
        guard let teamPostcode = tfTeamPostcode.text else { return }
        
        let spinner = UIViewController.displayLoading(withView: self.view)
        
        Auth.auth().createUser(withEmail: playerEmailAddress, password: playerPassword) { [weak self] (user, error) in
            
            guard let strongSelf = self else { return }
            
            if error == nil {
                
                guard let userId = user?.user.uid else { return }
                
                Auth.auth().signIn(withEmail: self!.playerEmailAddress, password: self!.playerPassword) { (user, error) in
                    DispatchQueue.main.async {
                        UIViewController.removeLoading(spinner: spinner)
                    }
                    if error == nil {
                        
                        //Add user to the database
                        let playerDictionary : [String:Any] =
                        [
                            "id": userId,
                            "fullName" : self!.playerFullName,
//                                "imageURL" : self!.playerProfilePicture!,
                            "email" : self!.playerEmailAddress,
                            "dateOfBirth" : self!.playerDateOfBirth,
                            "houseNumber" : self!.playerHouseNumber,
                            "postcode" : self!.playerPostcode,
                            "manager" : true,
                            "playerManager" : self!.playerManager,
                            "position" : self!.playerPosition
                        ]
                        
                        let teamRef = Database.database().reference().child("teams").childByAutoId()
                        let newKey = teamRef.key
                        let TeamDictionary : [String:Any] = ["name": teamName, "pin": teamPIN, "postcode":teamPostcode, "id": newKey as Any, "players": [playerDictionary]]
                        teamRef.setValue(TeamDictionary)
                        
                        DispatchQueue.main.async {
                            Helper.login()
                        }
                        
                    } else if let error = error  {
                        print(error.localizedDescription)
                        
//                        Helper.signupError(error: error)
                        
                        //DUPLICATE CODE?
                        var errorTitle: String = "Signup Error"
                        var errorMessage: String = "There was a problem signing up"
                        if let errorCode = AuthErrorCode(rawValue: error._code) {
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
                            let alert = Helper.errorAlert(title: errorTitle, message: errorMessage)
                            DispatchQueue.main.async {
                                strongSelf.present(alert, animated: true, completion: nil)
                            }
                        }
                        
                    }
                }
                
            } else if let error = error {
                print(error.localizedDescription)
                
                //DUPLICATE CODE?
                var errorTitle: String = "Login Error"
                var errorMessage: String = "There was a problem loggin in"
                if let errorCode = AuthErrorCode(rawValue: error._code) {
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
                    let alert = Helper.errorAlert(title: errorTitle, message: errorMessage)
                    DispatchQueue.main.async {
                        strongSelf.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
        }
        
    }
    
}
