//
//  LoginViewController.swift
//  TBG2
//
//  Created by Kris Reid on 09/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var ivTbgLogo: UIImageView!
    @IBOutlet weak var vAuthentication: UIView!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        Helper.login()
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        print("Sign me up y'all")
    }
    
    

}
