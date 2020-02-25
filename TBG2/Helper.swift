//
//  Helper.swift
//  TBG2
//
//  Created by Kris Reid on 09/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

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
    
}
