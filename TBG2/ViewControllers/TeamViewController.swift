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
    
    lazy var team: [Team] = {
        let teamModel = TeamModel()
        return teamModel.teamList
    } ()
    
    let teamData: [Team] = TeamModel.init().teamList
    
    let sectionTitles: [String] = ["Goalkeepers","Defenders","Midfielders","Strikers"]
    
    let s1Data: [Player] = PlayersModel.init().goalkeeperList
    let s2Data: [Player] = PlayersModel.init().defenderList
    let s3Data: [Player] = PlayersModel.init().midfielderList
    let s4Data: [Player] = PlayersModel.init().strikerList

    var sectionData: [Int: [Player]] = [:]
    
    //instantiate the Xib
    var xibview = UINib(nibName: "ShareTeamView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ShareTeamView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionData = [0 : s1Data, 1 : s2Data, 2 : s3Data, 3 : s4Data]

        tableview.estimatedRowHeight = CGFloat(60.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
        //Bar Button Items
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: self, action: #selector(shareTeamInformationTapped))
        
        
        //Xib Code
        xibview.layer.cornerRadius = CGFloat(10)
        xibview.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: xibview.bounds.height)
        
        xibview.layer.shadowColor = UIColor.black.cgColor
        xibview.layer.shadowOpacity = 1
        xibview.layer.shadowRadius = 10
        
        view.addSubview(xibview)
        
        xibview.ivClubBadge.image = teamData[0].teamImage
        xibview.lblClubName.text = teamData[0].teamName
        xibview.lblClubPostcode.text = teamData[0].teamPostcode
        
        //Downswipe (Add Fixture)
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        downSwipe.direction = .down
        xibview.addGestureRecognizer(downSwipe)
        
        
    }
    
    //Look into this
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
                view.backgroundColor = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 )

        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.frame = CGRect(x: 10, y: 0, width: 100, height: 34)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
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
    
    
    @objc func shareTeamInformationTapped() {
        
        UIView.animate(withDuration: 0.6) {
            self.xibview.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - self.xibview.bounds.height, width: UIScreen.main.bounds.width, height: self.xibview.bounds.height)
        }
        
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .down) {
            print("Swipe Down")
            UIView.animate(withDuration: 0.6) {
                self.xibview.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: self.xibview.bounds.height)
            }
        }
    }
    
}
