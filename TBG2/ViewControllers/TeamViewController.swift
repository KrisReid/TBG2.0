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
    
    let sectionTitles: [String] = ["Goalkeepers","Defenders","Midfielders","Strikers"]
    
    let s1Data: [Player] = PlayersModel.init().goalkeeperList
    let s2Data: [Player] = PlayersModel.init().defenderList
    let s3Data: [Player] = PlayersModel.init().midfielderList
    let s4Data: [Player] = PlayersModel.init().strikerList

    var sectionData: [Int: [Player]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionData = [0 : s1Data, 1 : s2Data, 2 : s3Data, 3 : s4Data]

        tableview.estimatedRowHeight = CGFloat(74.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
        
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: nil, action: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
                view.backgroundColor = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 )

        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.frame = CGRect(x: 10, y: 0, width: 100, height: 40)
        label.textColor = UIColor.white
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell

        cell.lblPlayerName.text = sectionData[indexPath.section]![indexPath.row].playerName
        cell.ivPlayerImage.image = sectionData[indexPath.section]![indexPath.row].playerImage
        
        return cell
        
    }

}
