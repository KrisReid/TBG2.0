//
//  LoginViewController.swift
//  TBG2
//
//  Created by Kris Reid on 09/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var ivTbgLogo: UIImageView!
    @IBOutlet weak var vAuthentication: UIView!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var colour = Colours()
    var keyboardHeight : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Accessability Identifiers
        setupAccessibilityAndLocalisation()
        
        //Styling
        tfEmailAddress.underlined(colour: colour.white.cgColor)
        tfPassword.underlined(colour: colour.white.cgColor)
        tfEmailAddress.textColor = .white
        tfPassword.textColor = .white
        tfEmailAddress.whitePlaceholderText(text: "Email Address")
        tfPassword.whitePlaceholderText(text: "Password")
    }
    
    private func setupAccessibilityAndLocalisation() {
        tfEmailAddress.accessibilityIdentifier = AccessabilityIdentifier.LoginEmail.rawValue
        tfPassword.accessibilityIdentifier = AccessabilityIdentifier.LoginPassword.rawValue
        btnLogin.accessibilityIdentifier = AccessabilityIdentifier.LoginButton.rawValue
        btnSignUp.accessibilityIdentifier = AccessabilityIdentifier.LoginSignupButton.rawValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        
        guard let email = tfEmailAddress.text else { return }
        guard let password = tfPassword.text else { return }
        
        let spinner = UIViewController.displayLoading(withView: self.view)
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                UIViewController.removeLoading(spinner: spinner)
            }
            if error == nil {
                DispatchQueue.main.async {
                    //login
                    Helper.login()
                }
            }
            else if let error = error {
                print(error.localizedDescription)
                let alert = Helper.loginError(error: error)
                DispatchQueue.main.async {
                    strongSelf.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if self.keyboardHeight == 0 {
                self.keyboardHeight = keyboardHeight
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardHeight
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += self.keyboardHeight
                self.keyboardHeight = 0.0
            }
        }
    }
    
    //closes the keyboard when you touch white space
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
