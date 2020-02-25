//
//  CreateTeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 23/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class CreateTeamViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnTeamCrest: UIButton!
    @IBOutlet weak var tfTeamName: UITextField!
    @IBOutlet weak var tfTeamPIN: UITextField!
    @IBOutlet weak var tfTeamPostcode: UITextField!
    @IBOutlet weak var scPlayerManager: UISegmentedControl!
    @IBOutlet weak var scPlayerPosition: UISegmentedControl!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    var colour = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Keyboard Dismissal
        self.setupHideKeyboardOnTap()
        
        //Buttons
        btnTeamCrest.circle(colour: colour.white.cgColor)
        
        //TextFields
        tfTeamName.underlined(colour: colour.white.cgColor)
        tfTeamPIN.underlined(colour: colour.white.cgColor)
        tfTeamPostcode.underlined(colour: colour.white.cgColor)
        tfTeamName.whitePlaceholderText(text: "Team Name")
        tfTeamPIN.whitePlaceholderText(text: "Team PIN")
        tfTeamPostcode.whitePlaceholderText(text: "Team Postcode")
        
        //Segmented Control
        scPlayerManager.defaultSegmentedControlFormat(backgroundColour: UIColor.clear)
        scPlayerPosition.defaultSegmentedControlFormat(backgroundColour: UIColor.clear)
        
    }
    
    @IBAction func btnTeamCrestTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //WHY CAN THIS NOT BE A SHARED FUNCTION
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        btnTeamCrest.setImage(image , for: UIControl.State.normal)
        btnTeamCrest.setTitle("",for: .normal)
    }
    
    
    @IBAction func scPlayerManagerTapped(_ sender: Any) {
        if scPlayerManager.selectedSegmentIndex == 1 {
            scPlayerPosition.isHidden = false
        } else {
            scPlayerPosition.isHidden = true
        }
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
    }
    
}
