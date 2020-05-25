//
//  TeamPinViewController.swift
//  TBG2
//
//  Created by Kris Reid on 02/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class TeamPinViewController: UIViewController {
    
    @IBOutlet weak var tfTeamPIN: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    
    var colours = Colours()
    var teamPIN: Int!
    var teamId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        btnDone.baseStyle()

        tfTeamPIN.text = teamPIN?.description
        
        //PIN Validation
        pinValidation()
    }
    
    @IBAction func tfTeamPINValueChanged(_ sender: Any) {
        pinValidation()
    }
    
    func pinValidation() {
        if tfTeamPIN.text?.count == 6 {
            btnDone.isEnabled = true
            btnDone.backgroundColor = colours.secondaryBlue
            tfTeamPIN.underlined(colour: colours.secondaryBlue.cgColor)
        } else {
            btnDone.isEnabled = false
            btnDone.backgroundColor = colours.primaryGrey
            tfTeamPIN.underlined(colour: colours.primaryGrey.cgColor)
        }
    }
    
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        guard let pin = tfTeamPIN.text else { return }
        TeamModel.postTeamPIN(teamId: teamId, teamPIN: Int(pin) ?? 000000)
        dismiss(animated: true, completion: nil)
    }
    
}
