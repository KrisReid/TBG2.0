//
//  FixtureDetailViewController.swift
//  TBG2
//
//  Created by Kris Reid on 19/01/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class FixtureDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var vScore: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var test: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.estimatedRowHeight = CGFloat(50.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixtureDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FixtureDetailTableViewCell")
        
        
        //instantiate the Xib
        let xibview = UINib(nibName: "Score", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Score
        
        //Xib Code
        xibview.frame = CGRect(x: vScore.bounds.origin.x, y: vScore.bounds.origin.y , width: UIScreen.main.bounds.width, height: vScore.bounds.height)
        
        vScore.addSubview(xibview)

//        xibview.ivClubBadge.image = teamData[0].teamImage
//        xibview.lblClubName.text = teamData[0].teamName
//        xibview.lblClubPostcode.text = teamData[0].teamPostcode
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureDetailTableViewCell") as! FixtureDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "MOTM") {  (contextualAction, view, boolValue) in
            
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)

            let twitterAction = UIAlertAction(title: "Twitter", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            shareMenu.addAction(twitterAction)
            shareMenu.addAction(cancelAction)

            self.present(shareMenu, animated: true, completion: nil)
            
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }

}
