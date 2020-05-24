//
//  Helper.swift
//  TBG2
//
//  Created by Kris Reid on 09/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import CoreData

class Helper {
    
    class func errorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        return alert
    }
    
    
    class func login() {
        let tabController = UITabBarController()

        let teamStoryboard = UIStoryboard(name: "Team", bundle: nil)
        let fixturesStoryboard = UIStoryboard(name: "Fixtures", bundle: nil)
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)

        let teamVC = teamStoryboard.instantiateViewController(withIdentifier: "Team") as! TeamViewController
        let fixturesVC = fixturesStoryboard.instantiateViewController(withIdentifier: "Fixtures") as! FixturesViewController

        let settingsVC = settingsStoryboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController


        let vcData: [(UIViewController, UIImage, UIImage)] = [

            (teamVC, UIImage(named: "team_tab_icon")!, UIImage(named: "team_selected_tab_icon")!),
            (fixturesVC, UIImage(named: "fixtures_tab_icon")!, UIImage(named: "fixtures_selected_tab_icon")!),
            (settingsVC, UIImage(named: "settings_tab_icon")!, UIImage(named: "settings_selected_tab_icon")!)

        ]

        let vcs = vcData.map { (vc, defaultImage, selectedImage) -> UINavigationController in

            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem.image = defaultImage
            nav.tabBarItem.selectedImage = selectedImage
            return nav
        }

        tabController.viewControllers = vcs
        tabController.tabBar.isTranslucent = false
//        tabController.delegate = tabBarDelegate

        if let items = tabController.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                if let selectedImage = item.selectedImage {
                    item.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }

        UINavigationBar.appearance().backgroundColor = UIColor.white
        
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            guard let window = sd.window else { return }
            window.rootViewController = tabController
        }
    }
    
    
    class func logout() {
        do {
            try Auth.auth().signOut()
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                guard let window = sd.window else { return }
                window.rootViewController = loginViewController
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    class func signupError(error: Error) -> UIAlertController {
        let rawErrorCode = error._code
        var errorTitle: String = "Signup Error"
        var errorMessage: String = "There was a problem signing up"
        if let errorCode = AuthErrorCode(rawValue: rawErrorCode) {
            switch errorCode {
            case .emailAlreadyInUse:
                errorTitle = "Email in use"
                errorMessage = "The email address you provided is already in use"
            case .invalidEmail:
                errorTitle = "Invalid Email"
                errorMessage = "Please enter a valid email address"
            case .weakPassword:
                errorTitle = "Weak password provided"
                errorMessage = "Please enter a stronger password"
            default:
                break
            }
        }
        return Helper.errorAlert(title: errorTitle, message: errorMessage)
    }
    
    
    class func loginError(error: Error) -> UIAlertController {
        let rawErrorCode = error._code
        var errorTitle: String = "Login Error"
        var errorMessage: String = "There was a problem loggin in"
        if let errorCode = AuthErrorCode(rawValue: rawErrorCode) {
            switch errorCode {
            case .emailAlreadyInUse:
                errorTitle = "Email in use"
                errorMessage = "The email address you provided is already in use"
            case .wrongPassword:
                errorTitle = "Incorrect Password"
                errorMessage = "The password provided is incorrect"
            case .invalidEmail:
                errorTitle = "Invalid Email"
                errorMessage = "Please enter a valid email address"
            default:
                break
            }
        }
        return Helper.errorAlert(title: errorTitle, message: errorMessage)
    }
    
    class func ImageUrlConverter (url: URL) -> UIImageView {
        let image = UIImageView()
        image.sd_cancelCurrentImageLoad()
        image.sd_setImage(with: url, completed: nil)
        return image
    }
    
    class func setImageView (imageView: UIImageView, url: URL) {
        imageView.sd_cancelCurrentImageLoad()
        imageView.sd_setImage(with: url, completed: nil)
    }
    
    
    class func openMapForPlace(longitude: Double, latitude: Double, opposition: String) {
        let latitude: CLLocationDegrees = latitude
        let longitude: CLLocationDegrees = longitude

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = opposition
        mapItem.openInMaps(launchOptions: options)
    }
    

    class func removeSpaces(text: String) -> String {
        return text.replacingOccurrences(of: " ", with: "")
    }
    
    
    class func stringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy"
        let fixtureDate = dateFormatter.date(from: date)!
        return fixtureDate
    }
}
