//
//  SceneDelegate.swift
//  TBG2
//
//  Created by Kris Reid on 29/08/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//
import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        FirebaseApp.configure()
        
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)

        if let _ = Auth.auth().currentUser {
            
            //LOGIC BUG MEANING I CAN"T USE HELPER.LOGIN ----- WHY????
//            Helper.login()
            
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
            window.rootViewController = tabController

                    
        } else {
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            window.rootViewController = loginViewController
        }

        self.window = window
        window.makeKeyAndVisible()

    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
