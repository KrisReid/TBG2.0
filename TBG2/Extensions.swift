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
    
    func placeholderText (text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    

    
}

