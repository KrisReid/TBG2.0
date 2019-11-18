//
//  TeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    lazy var players: [Player] = {
        let model = PlayersModel()
        return model.playerList
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.estimatedRowHeight = CGFloat(88.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayersTableViewCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
        //remove the lines in a table view
//        tableview.tableFooterView = UIView()
        
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: nil, action: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        return cell
        
    }

}
