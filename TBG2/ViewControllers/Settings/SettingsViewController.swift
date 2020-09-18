//
//  SettingsViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

struct Settings {
    var title: String
    var answer: String
    var image: Bool
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var settingsList: [Settings] = []
    var colours = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setting1 = Settings(title: "Team Information", answer: "", image: false)
        let setting2 = Settings(title: "Managers", answer: "", image: false)
        let setting3 = Settings(title: "Season Settings", answer: "123456", image: false)
        let setting4 = Settings(title: "Sign Out", answer: "", image: true)

        settingsList.append(setting1)
        settingsList.append(setting2)
        settingsList.append(setting3)
        settingsList.append(setting4)
        
        tableview.estimatedRowHeight = CGFloat(60.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
        
        cell.lblTitle.text = settingsList[indexPath.row].title
        if settingsList[indexPath.row].image == true {
            cell.ivNext.image = UIImage(named: "small_error_next_icon")
            cell.lblTitle.textColor = colours.red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "teamInformationSegue", sender: nil)
            case 1:
                performSegue(withIdentifier: "managersSegue", sender: nil)
            case 2:
                performSegue(withIdentifier: "seasonSettingsSegue", sender: nil)
            case 3:
                Helper.logout()
            default:
                print("Invalid Response")
        }
    }
    
    //Some comments for testing.
    
    //Some more comments for testing
}
