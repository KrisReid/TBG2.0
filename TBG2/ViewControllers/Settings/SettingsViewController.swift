//
//  SettingsViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
        print("I HAVE BEEN TAPPED YOU KNOW")
        Helper.logout()
        print("I HAVE BEEN TAPPED YOU KNOW")
    }
    
    

}
