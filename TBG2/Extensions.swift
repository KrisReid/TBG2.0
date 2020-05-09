//
//  Extensions.swift
//  TBG2
//
//  Created by Kris Reid on 06/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit

// Maybe move these classes to helper????
class Colours {
    var primaryBlue = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 )
    var secondaryBlue = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 )
    var tertiaryBlue = UIColor( red: 37/255, green: 71/255, blue:77/255, alpha: 1.0 )
    var primaryGrey = UIColor( red: 120/255, green: 120/255, blue:120/255, alpha: 1.0 )
    var white = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 )
    var red = UIColor(red: 206/255, green: 50/255, blue: 50/255, alpha: 1.0)
    var green = UIColor(red: 40/255, green: 191/255, blue: 38/255, alpha: 1.0)
    var yellow = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0)
}

class Circles {
    func circles (name: AnyObject, colour: CGColor) {
        name.layer.cornerRadius = name.frame.width / 2
        name.layer.masksToBounds = true
        name.layer.borderWidth = 1.0
        name.layer.borderColor = colour
    }
}

extension UIViewController {
    class func displayLoading(withView: UIView) -> UIView {
        //background view for spinner
        let spinnerView = UIView.init(frame: withView.bounds)
        spinnerView.backgroundColor = UIColor.clear
        
        //Spinner size/colour and animation
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.color = .white
        ai.startAnimating()
        ai.center = spinnerView.center
        
        //Async call
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            withView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    class func removeLoading(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
}

extension UIImageView {
    func circle (colour: CGColor) {
        Circles.init().circles(name: self, colour: colour)
    }
}

extension UIButton {
    func circle (colour: CGColor) {
        Circles.init().circles(name: self, colour: colour)
    }
    
    func baseStyle () {
        self.layer.cornerRadius = 5
        self.backgroundColor = Colours.init().secondaryBlue
    }
}

extension UILabel {
    func circle (colour: CGColor) {
        Circles.init().circles(name: self, colour: colour)
    }
}

extension UITextField {
    func underlined (colour: CGColor) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = colour
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func whitePlaceholderText (text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }

}

extension UIDatePicker {
    func standardDateFormat (datePicker: UIDatePicker, textField: UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return textField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func standardDatePicker (datePicker: UIDatePicker) {
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
        datePicker.frame.size.height = 250
    }
    
}

extension UISegmentedControl {
    func defaultSegmentedControlFormat (backgroundColour: UIColor) {
        
        let blueText = [NSAttributedString.Key.foregroundColor: Colours.init().secondaryBlue, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
        let whiteText = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
        
        self.setTitleTextAttributes(whiteText, for: .normal)
        self.setTitleTextAttributes(blueText, for: .selected)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = Colours.init().tertiaryBlue.cgColor
        self.backgroundColor = backgroundColour
    }
}


//extension UIImagePickerControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true)
//
//        guard let image = info[.editedImage] as? UIImage else {
//            print("No image found")
//            return
//        }
//
////        self.setImage(image , for: UIControl.State.normal)
////        self.setTitle("",for: .normal)
//    }
//}


//protocol ToolbarPickerViewDelegate: class {
//    func didTapDone()
//    func didTapCancel()
//}
//
//class ToolbarPickerView: UIPickerView {
//
//    public private(set) var toolbar: UIToolbar?
//    public weak var toolbarDelegate: ToolbarPickerViewDelegate?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.commonInit()
//    }
//
//    private func commonInit() {
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = .black
//        toolBar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))
//
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
//        self.toolbar = toolBar
//    }
//
//    @objc func doneTapped() {
//        self.toolbarDelegate?.didTapDone()
//    }
//
//    @objc func cancelTapped() {
//        self.toolbarDelegate?.didTapCancel()
//    }
//}
