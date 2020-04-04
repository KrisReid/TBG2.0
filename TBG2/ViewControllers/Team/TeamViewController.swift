//
//  TeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var colours = Colours()
    var player: PlayerModel?
    
    
    var goalkeepers: NSMutableArray = []
    var defenders: NSMutableArray = []
    var midfielders: NSMutableArray = []
    var strikers: NSMutableArray = []
    let sectionTitles: [String] = ["Goalkeepers","Defenders","Midfielders","Strikers"]
    var sectionData: [Int: NSMutableArray] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionData = [0 : goalkeepers, 1 : defenders, 2 : midfielders, 3 : strikers]

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
        loadPlayerData()
        
    }
    
    func loadPlayerData() {
        print("TRIGGRERED...")
        let playerRef = Helper.getPlayer()
        playerRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let player = PlayerModel(snapshot) else {return}
            strongSelf.player = player
            
            //Helper?
            let playersRef = TeamModel.collection.child(strongSelf.player?.teamId ?? "").child("players")
            let playerRefQuery = playersRef.queryOrderedByKey()
            playerRefQuery.observeSingleEvent(of: .value) { [weak self] (snapshot) in
                guard let strongSelf = self else { return }
                for item in snapshot.children {
                    guard let snapshot = item as? DataSnapshot else { continue }
                    guard let player = PlayerModel(snapshot) else { continue }
                    
                    switch player.position {
                    case "Goalkeeper":
                        strongSelf.goalkeepers.insert(player, at: 0)
                    case "Defender":
                        strongSelf.defenders.insert(player, at: 0)
                    case "Midfielder":
                        strongSelf.midfielders.insert(player, at: 0)
                    case "Striker":
                        strongSelf.strikers.insert(player, at: 0)
                    default:
                        break
                    }
                }
                DispatchQueue.main.async {
                    strongSelf.tableview.reloadData()
                }
            }
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
        
        let players = sectionData[indexPath.section]![indexPath.row] as! PlayerModel
        
        cell.lblPlayerName.text = players.position
//        cell.ivPlayerImage.image = players.profilePictureUrl
        
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
