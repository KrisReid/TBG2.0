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
    
    var teamPIN: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        btnDone.baseStyle()
        tfTeamPIN.underlined(colour: Colours.init().secondaryBlue.cgColor)

        tfTeamPIN.text = teamPIN
    }

    @IBAction func btnDoneClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
