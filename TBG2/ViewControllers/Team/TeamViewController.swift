//
//  TeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var colours = Colours()
    var defaultPlayer: PlayerModel?
    
    var managers: NSMutableArray = []
    var goalkeepers: NSMutableArray = []
    var defenders: NSMutableArray = []
    var midfielders: NSMutableArray = []
    var strikers: NSMutableArray = []
    let sectionTitles: [String] = ["Managers","Goalkeepers","Defenders","Midfielders","Strikers"]
    var sectionData: [Int: NSMutableArray] = [:]
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Generate FCM Token
        TokenGeneration().viewDidLoad()
        
        //Set section structure
        sectionData = [0 : managers, 1 : goalkeepers, 2 : defenders, 3 : midfielders, 4 : strikers]

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
        loadData()
        
        //Refresh Controller
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        loadData()
    }
        
    
    func loadData() {
        //Get the user & player data
        let uuid = PlayerModel.authCollection
        let userRef = PlayerModel.collection.child(uuid)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let player = PlayerModel(snapshot) else {return}
            
            //LOAD THE ONLY USEr OBJECT ONCE
            PlayerModel.user = player
                
            let playersRef = TeamModel.collection.child(PlayerModel.user?.teamId ?? "").child("players")
            let playerRefQuery = playersRef.queryOrderedByKey()
            
            playerRefQuery.observe( .value) { [weak self] (snapshot) in
                
                self!.managers.removeAllObjects()
                self!.goalkeepers.removeAllObjects()
                self!.defenders.removeAllObjects()
                self!.midfielders.removeAllObjects()
                self!.strikers.removeAllObjects()
                
                guard let strongSelf = self else { return }
                for item in snapshot.children {
                    
                    guard let snapshot = item as? DataSnapshot else { continue }
                    guard let player = PlayerModel(snapshot) else { continue }
                    
                    if player.manager || player.assistantManager {
                        strongSelf.managers.insert(player, at: 0)
                    } else {
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
                }

                //Default player code
                let DefaultPlayerRef = PlayerModel.getDefaultPlayer()
                DefaultPlayerRef.observeSingleEvent(of: .value) { (snapshot) in
                    guard let defaultPlayer = PlayerModel(snapshot) else {return}
                    
                    //Load a default player into any empty array and reload
                    if self?.goalkeepers.count == 0 {
                        strongSelf.goalkeepers.insert(defaultPlayer, at: 0)
                    }
                    if self?.defenders.count == 0 {
                        strongSelf.defenders.insert(defaultPlayer, at: 0)
                    }
                    if self?.midfielders.count == 0 {
                        strongSelf.midfielders.insert(defaultPlayer, at: 0)
                    }
                    if self?.strikers.count == 0 {
                        strongSelf.strikers.insert(defaultPlayer, at: 0)
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.tableview.reloadData()
                        strongSelf.refreshControl.endRefreshing()
                    }
                    
                }
            }
        }
    }
    
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(sectionData[section]?.count)!
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
        
        if players.id == "DefaultPlayerToPull123456789" {
            cell.lblPlayerName.isHidden = true
            cell.ivNextIcon.isHidden = true
            cell.ivPlayerImage.isHidden = true
            cell.lblNoPlayer.isHidden = false
            cell.lblNoPlayer.text = players.fullName
        } else{
            cell.lblPlayerName.text = players.fullName
            cell.ivPlayerImage.sd_cancelCurrentImageLoad()
            cell.ivPlayerImage?.sd_setImage(with: players.profilePictureUrl, completed: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = sectionData[indexPath.section]![indexPath.row] as! PlayerModel
        
        if snapshot.id != "DefaultPlayerToPull123456789" {
            performSegue(withIdentifier: "playerDetailSegue", sender: snapshot)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayerDetailViewController {
            if let snapshot = sender as? PlayerModel {
                vc.playerName = snapshot.fullName
                vc.playerProfilePicUrl = snapshot.profilePictureUrl
                vc.playerDateOfBirth = snapshot.dateOfBirth
                vc.playerPosition = snapshot.position
                vc.playerGamesTotal = snapshot.gamesTotal
                vc.playerGoalTotal = snapshot.goalTotal
                vc.playerMotmTotal = snapshot.motmTotal
                vc.playerId = snapshot.id
                vc.teamId = snapshot.teamId
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
