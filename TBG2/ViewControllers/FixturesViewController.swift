//
//  FixturesViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class FixturesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    lazy var team: [Team] = {
        let teamModel = TeamModel()
        return teamModel.teamList
    } ()

    let teamData: [Team] = TeamModel.init().teamList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(teamData)
        
        tableview.estimatedRowHeight = CGFloat(70.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixturesTableViewCell", bundle: nil), forCellReuseIdentifier: "FixturesTableViewCell")
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixturesTableViewCell") as! FixturesTableViewCell
        return cell
    }
    

}
