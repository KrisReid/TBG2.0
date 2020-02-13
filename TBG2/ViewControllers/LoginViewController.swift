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
    
    var colour = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfEmailAddress.underlined(colour: Colours.init().white.cgColor)
        tfPassword.underlined(colour: Colours.init().white.cgColor)
        tfEmailAddress.textColor = .white
        tfPassword.textColor = .white

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
                    print("8888888 No Errors and using the helper login function")
                    Helper.login()
                }
            }
            else if let error = error {
                var errorTitle: String = "Login Error"
                var errorMessage: String = "There was a problem loggin in"
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    case .wrongPassword:
                        errorTitle = "Wrong Password"
                        errorMessage = "The password provided is wrong"
                    case .invalidEmail:
                        errorTitle = "Invalid Email"
                        errorMessage = "Please enter a valid email address"
                    default:
                        break
                    }
                    let alert = Helper.errorAlert(title: errorTitle, message: errorMessage)
                    DispatchQueue.main.async {
                        strongSelf.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        print("Sign me up y'all")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 300
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 300
            }
        }
    }
    
    //closes the keyboard when you touch white space
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //enter button will close the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
