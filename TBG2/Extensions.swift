//
//  Extensions.swift
//  TBG2
//
//  Created by Kris Reid on 06/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import Foundation
import UIKit

class Colours {
    var primaryBlue = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 )
    var secondaryBlue = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 )
    var tertiaryBlue = UIColor( red: 37/255, green: 71/255, blue:77/255, alpha: 1.0 )
    var primaryGrey = UIColor( red: 120/255, green: 120/255, blue:120/255, alpha: 1.0 )
}

class Circles {
    func circles (name: AnyObject, colour: CGColor) {
        name.layer.cornerRadius = name.frame.width / 2
        name.layer.masksToBounds = true
        name.layer.borderWidth = 1.0
        name.layer.borderColor = colour
    }
}

extension UIImageView {
    func circle (colour: CGColor) {
        Circles.init().circles(name: self, colour: colour)
    }
}

extension UILabel {
    func circle (colour: CGColor) {
        Circles.init().circles(name: self, colour: colour)
    }
}

extension UITextField {
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = Colours.init().secondaryBlue.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

