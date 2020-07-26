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
        Helper.pinValidation(textField: tfTeamPIN, button: btnDone, enabledUnderlineColour: colours.secondaryBlue.cgColor, enabledeBtnColour: colours.secondaryBlue, disableRequired: true)
        
        //Accessability Identifiers
        setupAccessibilityAndLocalisation()
    }
    
    private func setupAccessibilityAndLocalisation() {
        tfTeamPIN.accessibilityIdentifier = AccessabilityIdentifier.TeamPINTeamPIN.rawValue
        btnDone.accessibilityIdentifier = AccessabilityIdentifier.TeamPINDone.rawValue
    }
    
    @IBAction func tfTeamPINValueChanged(_ sender: Any) {
        Helper.pinValidation(textField: tfTeamPIN, button: btnDone, enabledUnderlineColour: colours.secondaryBlue.cgColor, enabledeBtnColour: colours.secondaryBlue, disableRequired: true)
    }
    
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        guard let pin = tfTeamPIN.text else { return }
        TeamModel.postTeamPIN(teamId: teamId, teamPIN: Int(pin) ?? 000000)
        dismiss(animated: true, completion: nil)
    }
    
}
