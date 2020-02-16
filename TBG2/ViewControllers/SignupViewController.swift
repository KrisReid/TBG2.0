//
//  SignupViewController.swift
//  TBG2
//
//  Created by Kris Reid on 13/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var vPlayerSignupDetails: UIView!
    @IBOutlet weak var btnProfilePicture: UIButton!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfDateOfBirth: UITextField!
    @IBOutlet weak var tfHouseNumber: UITextField!
    @IBOutlet weak var tfPostcode: UITextField!
    @IBOutlet weak var btnCreateTeam: UIButton!
    @IBOutlet weak var btnJoinTeam: UIButton!
    
    var colour = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHideKeyboardOnTap()
        
        tfFullName.underlined(colour: colour.white.cgColor)
        tfEmailAddress.underlined(colour: colour.white.cgColor)
        tfPassword.underlined(colour: colour.white.cgColor)
        tfDateOfBirth.underlined(colour: colour.white.cgColor)
        tfHouseNumber.underlined(colour: colour.white.cgColor)
        tfPostcode.underlined(colour: colour.white.cgColor)
        
        tfFullName.whitePlaceholderText(text: "Full Name")
        tfEmailAddress.whitePlaceholderText(text: "Email Address")
        tfPassword.whitePlaceholderText(text: "Password")
        tfDateOfBirth.whitePlaceholderText(text: "Date of birth")
        tfHouseNumber.whitePlaceholderText(text: "House Number")
        tfPostcode.whitePlaceholderText(text: "Postcode")
        
        btnProfilePicture.circle(colour: colour.white.cgColor)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func btnProfilePictureTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnCreateTeamTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnJoinTeamTapped(_ sender: Any) {
        
    }
    
    @objc func keyboardWillShow(notificationa: NSNotification) {
        if ((notificationa.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 250
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 250
            }
        }
    }
    
    

}
