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
    
    var colour = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTeamCrest.circle(colour: colour.white.cgColor)

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
    

}
