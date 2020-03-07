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
//        guard let teamCrest = btnTeamCrest.imageView else { return }
        guard let teamPIN = Int(tfTeamPIN.text!) else { return }
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
                        Helper.postNewTeam(userId: userId, playerFullName: self!.playerFullName, playerEmailAddress: self!.playerEmailAddress, playerDateOfBirth: self!.playerDateOfBirth, playerHouseNumber: self!.playerHouseNumber, playerPostcode: self!.playerPostcode, manager: true, playerManager: self!.playerManager, playerPosition: self!.playerPosition, teamName: teamName, teamPIN: teamPIN, teamPostcode: teamPostcode)
                        
                        DispatchQueue.main.async {
                            Helper.login()
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
    
}
