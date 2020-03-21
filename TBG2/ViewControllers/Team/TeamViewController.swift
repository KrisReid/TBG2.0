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
    
    var colours = Colours()
    var team: TeamModel?
    
    
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

        tableview.estimatedRowHeight = CGFloat(60.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
        //Bar Button Items
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: self, action: #selector(shareTeamInformationTapped))
        
        //Load Data
        getTeam()
    }
    
    func getTeam() {

        
        
        let teamRef = TeamModel.collection
        let spinner = UIViewController.displayLoading(withView: self.view)
        teamRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            UIViewController.removeLoading(spinner: spinner)
            guard let teams = TeamModel(snapshot) else { return }
            strongSelf.teams = teams
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = colours.secondaryBlue

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = sectionData[indexPath.section]![indexPath.row]
        performSegue(withIdentifier: "playerDetailSegue", sender: snapshot)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayerDetailViewController {
            if let snapshot = sender as? Player {
                vc.playerName = snapshot.playerName
                vc.playerProfilePic = snapshot.playerImage
                vc.playerAge = snapshot.playerAge
                vc.playerPosition = snapshot.playerPostion
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == UITableViewCell.EditingStyle.delete {
             print(indexPath.row)
         }
     }
    
    @objc func shareTeamInformationTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Team", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ShareTeamViewController") as! ShareTeamViewController
        self.present(nextViewController, animated: true, completion: nil)
    }

}
