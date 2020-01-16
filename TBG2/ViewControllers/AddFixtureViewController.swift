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
    
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    
    var colour = Colours()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfOpposition.underlined()
        tfDate.underlined()
        tfTime.underlined()
        tfPostcode.underlined()

        //Segmented Control
        scHomeAway.layer.backgroundColor = colour.secondaryBlue.cgColor
        scHomeAway.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], for: .normal)
        
        //Date Picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddFixtureViewController.dateChanged(datePicker:)), for: .valueChanged)
        tfDate.inputView = datePicker
        
        //TimePicker
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.minuteInterval = 15
        timePicker?.addTarget(self, action: #selector(AddFixtureViewController.timeChanged(timePicker:)), for: .valueChanged)
        tfTime.inputView = timePicker
    }
    
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        tfDate.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        tfTime.text = timeFormatter.string(from: timePicker.date)
    }
    
    
    //closes the keyboard when you touch white space
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
