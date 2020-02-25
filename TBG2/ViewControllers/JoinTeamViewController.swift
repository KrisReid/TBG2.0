//
//  JoinTeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 25/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class JoinTeamViewController: UIViewController {
    
    @IBOutlet weak var tfTeamID: UITextField!
    @IBOutlet weak var tfTeamPIN: UITextField!
    @IBOutlet weak var scPlayerPosition: UISegmentedControl!
    
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
        
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
    }

}
