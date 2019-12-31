//
//  AddFixtureViewController.swift
//  TBG2
//
//  Created by Kris Reid on 29/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class AddFixtureViewController: UIViewController {
    
    @IBOutlet weak var scHomeAway: UISegmentedControl!
    @IBOutlet weak var tfOpposition: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var tfPostcode: UITextField!
    
    var colour = Colours()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfOpposition.underlined()
        tfDate.underlined()
        tfTime.underlined()
        tfPostcode.underlined()

        scHomeAway.layer.backgroundColor = colour.secondaryBlue.cgColor
        scHomeAway.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], for: .normal)
    }
    

}
