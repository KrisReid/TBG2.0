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
    var player: PlayerModel?
    var managers: NSMutableArray = []
    var players: NSMutableArray = []
    let sectionTitles: [String] = ["Managers","Players"]
    var sectionData: [Int: NSMutableArray] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionData = [0 : managers, 1 : players]
        
        //Load Data
        loadData()
    }
    
    func loadData() {
        self.managers.removeAllObjects()
        self.players.removeAllObjects()
        
        //Get the user & player data
        let userRef = PlayerModel.getUser()
        userRef.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let player = PlayerModel(snapshot) else {return}
            strongSelf.player = player
                
            let playersRef = TeamModel.collection.child(strongSelf.player?.teamId ?? "").child("players")
            let playerRefQuery = playersRef.queryOrderedByKey()
            
            playerRefQuery.observe(.value) { [weak self] (snapshot) in
                
                guard let strongSelf = self else { return }
                for item in snapshot.children {
                    
                    guard let snapshot = item as? DataSnapshot else { continue }
                    guard let player = PlayerModel(snapshot) else { continue }
                    
                    if player.manager || player.assistantManager {
                        strongSelf.managers.insert(player, at: 0)
                    } else {
                        strongSelf.players.insert(player, at: 0)
                    }
                    DispatchQueue.main.async {
                        strongSelf.tableview.reloadData()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagersTableViewCell") as! ManagersTableViewCell
        
        let player = sectionData[indexPath.section]![indexPath.row] as! PlayerModel
        
        cell.lblPlayerName.text = player.fullName
        cell.ivPlayerImage.sd_cancelCurrentImageLoad()
        cell.ivPlayerImage?.sd_setImage(with: player.profilePictureUrl, completed: nil)
        
        if player.manager || player.assistantManager {
            cell.btnAddRemove.setImage(UIImage(named: "decrement_icon"), for: .normal)
        } else {
            cell.btnAddRemove.setImage(UIImage(named: "increment_icon"), for: .normal)
        }
        
        return cell
    }
    
    @IBAction func btnAddRemoveTapped(_ sender: Any) {
        
        print("Puuusssshhhhhh")
    
    }
    
    
    
    
}
