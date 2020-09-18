//
//  ManagersViewController.swift
//  TBG2
//
//  Created by Kris Reid on 27/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ManagersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var colours = Colours()
    var managers: NSMutableArray = []
    var assistantManagers: NSMutableArray = []
    var players: NSMutableArray = []
    let sectionTitles: [String] = ["Managers","Assistant Managers","Players"]
    var sectionData: [Int: NSMutableArray] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionData = [0 : managers, 1 : assistantManagers, 2 : players]
        
        //Load Data
        loadData()
    }
    
    func loadData() {
        
        //Get the user & player data
        let playersRef = TeamModel.collection.child(PlayerModel.user!.teamId).child("players")
        let playerRefQuery = playersRef.queryOrderedByKey()
        playerRefQuery.observe(.value) { [weak self] (snapshot) in
            
            self!.managers.removeAllObjects()
            self!.assistantManagers.removeAllObjects()
            self!.players.removeAllObjects()
            
            guard let strongSelf = self else { return }
            for item in snapshot.children {
                
                guard let snapshot = item as? DataSnapshot else { continue }
                guard let player = PlayerModel(snapshot) else { continue }
                
                if player.manager {
                    strongSelf.managers.insert(player, at: 0)
                } else if player.assistantManager {
                    strongSelf.assistantManagers.insert(player, at: 0)
                } else {
                    strongSelf.players.insert(player, at: 0)
                }
                DispatchQueue.main.async {
                    strongSelf.tableview.reloadData()
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
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 34)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagersTableViewCell") as! ManagersTableViewCell
        
        let player = sectionData[indexPath.section]![indexPath.row] as! PlayerModel
        
        cell.lblPlayerName.text = player.fullName
        cell.ivPlayerImage.sd_cancelCurrentImageLoad()
        cell.ivPlayerImage?.sd_setImage(with: player.profilePictureUrl, completed: nil)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let player = sectionData[indexPath.section]![indexPath.row] as! PlayerModel
        
        //Player
        let playerAction = UIContextualAction(style: .normal, title: "Player") { (action, view, actionPerformed) in
            
            PlayerModel.postPlayersManagerialStatus(playerId: player.id, managerStatus: false, assistantStatus: false)
            TeamModel.postPlayersManagerialStatus(teamId: player.teamId, playerId: player.id, managerStatus: false, assistantStatus: false)
            actionPerformed(true)
        }
        playerAction.backgroundColor = colours.red
        playerAction.title = "Remove"
        
        
        //Manager
        let managerAction = UIContextualAction(style: .normal, title: "Manager") { (action, view, actionPerformed) in
            PlayerModel.postPlayersManagerialStatus(playerId: player.id, managerStatus: true, assistantStatus: false)
            TeamModel.postPlayersManagerialStatus(teamId: player.teamId, playerId: player.id, managerStatus: true, assistantStatus: false)
            actionPerformed(true)
        }
        managerAction.backgroundColor = colours.primaryBlue
        managerAction.title = "Manager"
        
        
        //Assistant Manager
        let assistantManagerAction = UIContextualAction(style: .normal, title: "Assistant Manager") { (action, view, actionPerformed) in
            PlayerModel.postPlayersManagerialStatus(playerId: player.id, managerStatus: false, assistantStatus: true)
            TeamModel.postPlayersManagerialStatus(teamId: player.teamId, playerId: player.id, managerStatus: false, assistantStatus: true)
            actionPerformed(true)
        }
        assistantManagerAction.backgroundColor = colours.tertiaryBlue
        assistantManagerAction.title = "Assistant"
                
        
        //Position Logic
        var swipeAction = UISwipeActionsConfiguration(actions: [])
        
        if player.manager && managers.count <= 1 {
//            swipeAction = UISwipeActionsConfiguration(actions: [])
        }
        if player.manager && managers.count > 1 {
            swipeAction = UISwipeActionsConfiguration(actions: [playerAction, assistantManagerAction])
        }
        if player.assistantManager && managers.count > 1 {
            swipeAction = UISwipeActionsConfiguration(actions: [playerAction])
        }
        if player.assistantManager && managers.count <= 1 {
            swipeAction = UISwipeActionsConfiguration(actions: [playerAction, managerAction])
        }
        if player.assistantManager == false && player.manager == false && managers.count > 1 {
              swipeAction = UISwipeActionsConfiguration(actions: [assistantManagerAction])
        }
        if player.assistantManager == false && player.manager == false && managers.count <= 1 {
              swipeAction = UISwipeActionsConfiguration(actions: [managerAction, assistantManagerAction])
        }
        
            
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    
}
