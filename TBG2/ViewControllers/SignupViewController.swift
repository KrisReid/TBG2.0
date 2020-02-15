//
//  SignupViewController.swift
//  TBG2
//
//  Created by Kris Reid on 13/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
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
        
        tfFullName.underlined(colour: colour.white.cgColor)
        tfEmailAddress.underlined(colour: colour.white.cgColor)
        tfPassword.underlined(colour: colour.white.cgColor)
        tfDateOfBirth.underlined(colour: colour.white.cgColor)
        tfHouseNumber.underlined(colour: colour.white.cgColor)
        tfPostcode.underlined(colour: colour.white.cgColor)
        
        btnProfilePicture.circle(colour: colour.white.cgColor)
        
    }
    
    @IBAction func btnProfilePictureTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnCreateTeamTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnJoinTeamTapped(_ sender: Any) {
        
    }
    

}
