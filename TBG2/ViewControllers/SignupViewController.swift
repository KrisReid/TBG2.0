//
//  SignupViewController.swift
//  TBG2
//
//  Created by Kris Reid on 13/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var vPlayerSignupDetails: UIView!
    @IBOutlet weak var btnProfilePicture: UIButton!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfDateOfBirth: UITextField!
    @IBOutlet weak var tfHouseNumber: UITextField!
    @IBOutlet weak var tfPostcode: UITextField!
    @IBOutlet weak var btnCreateTeam: UIButton!
    @IBOutlet weak var btnJoinTeam: UIButton!
    
    private var datePicker: UIDatePicker?
    
    var colour = Colours()
    var keyboardHeight : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Keyboard Dismissal
        self.setupHideKeyboardOnTap()
        
        //TextFields
        tfFullName.underlined(colour: colour.white.cgColor)
        tfEmailAddress.underlined(colour: colour.white.cgColor)
        tfPassword.underlined(colour: colour.white.cgColor)
        tfDateOfBirth.underlined(colour: colour.white.cgColor)
        tfHouseNumber.underlined(colour: colour.white.cgColor)
        tfPostcode.underlined(colour: colour.white.cgColor)
        tfFullName.whitePlaceholderText(text: "Full Name")
        tfEmailAddress.whitePlaceholderText(text: "Email Address")
        tfPassword.whitePlaceholderText(text: "Password")
        tfDateOfBirth.whitePlaceholderText(text: "Date of birth")
        tfHouseNumber.whitePlaceholderText(text: "House Number")
        tfPostcode.whitePlaceholderText(text: "Postcode")
        
        //Buttons
        btnProfilePicture.circle(colour: colour.white.cgColor)
        
        //Date Picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.frame.size.height = 250
        datePicker?.addTarget(self, action: #selector(AddFixtureViewController.dateChanged(datePicker:)), for: .valueChanged)
        tfDateOfBirth.inputView = datePicker
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func btnProfilePictureTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        btnProfilePicture.setImage(image , for: UIControl.State.normal)
        btnProfilePicture.setTitle("",for: .normal)
    }
    
    @IBAction func btnCreateTeamTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnJoinTeamTapped(_ sender: Any) {
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        datePicker.standardDateFormat(datePicker: datePicker, textField: tfDateOfBirth)
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

}
