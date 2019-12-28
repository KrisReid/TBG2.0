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

        tfTeamPIN.text = teamPIN
        btnDone.layer.cornerRadius = 5
    }

    @IBAction func btnDoneClicked(_ sender: Any) {
        print("Clicked Done Button")
        dismiss(animated: true, completion: nil)
    }
    

}
