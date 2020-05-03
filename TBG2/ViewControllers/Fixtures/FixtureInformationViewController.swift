//
//  FixtureInformationViewController.swift
//  TBG2
//
//  Created by Kris Reid on 01/03/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FixtureInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ivHomeTeam: UIImageView!
    @IBOutlet weak var ivAwayTeam: UIImageView!
    @IBOutlet weak var lblHomeGoals: UILabel!
    @IBOutlet weak var lblAwayGoals: UILabel!
    @IBOutlet weak var lblFixtureDate: UILabel!
    @IBOutlet weak var lblFixtureTime: UILabel!
    @IBOutlet weak var lblFixturePostcode: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    var teamId: String = ""
    var fixtureId: String = ""
    var teamCrestURL: URL?
    var homeGoals: String = ""
    var awayGoals: String = ""
    var homeFixture: Bool = true
    var fixtureDate: String = ""
    var fixtureTime: String = ""
    var fixturePostcode: String = ""
    
    var playerArray: NSMutableArray = []
    
    var colours = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblFixtureDate.text = fixtureDate
        lblFixtureTime.text = fixtureTime
        lblFixturePostcode.text = fixturePostcode
        lblHomeGoals.text = homeGoals
        lblAwayGoals.text = awayGoals
        
        //Styling
        ivHomeTeam.circle(colour: colours.primaryBlue.cgColor)
        ivAwayTeam.circle(colour: colours.primaryBlue.cgColor)

        //Table View
        tableview.estimatedRowHeight = CGFloat(50.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixtureDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FixtureDetailTableViewCell")
        
        //Display Crest
        if homeFixture {
            Helper.setImageView(imageView: ivHomeTeam, url: self.teamCrestURL!)
        } else {
            Helper.setImageView(imageView: ivAwayTeam, url: self.teamCrestURL!)
        }
        
        //Load Player Data
        loadPlayerFixtureData()
        
    }
    
    
    func loadPlayerFixtureData() {
        
        let fixtureRef = FixtureModel.collection.child(teamId).child(fixtureId).child("players")
        let fixtureRefQuery = fixtureRef.queryOrderedByKey()
        
        fixtureRefQuery.observeSingleEvent(of: .value) { (snapshot) in
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot else { continue }
                guard let player = PlayerFixtureModel(snapshot) else { continue }
                
                self.playerArray.insert(player, at: 0)
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureDetailTableViewCell") as! FixtureDetailTableViewCell
        
        let player = playerArray[indexPath.row] as! PlayerFixtureModel
        
        cell.lblPlayerName.text = player.fullName
        Helper.setImageView(imageView: cell.ivPlayer, url: player.profilePictureUrl!)
        
        switch player.availability {
        case "Yes":
            cell.ivPlayerAvailability.backgroundColor = colours.green
        case "No":
            cell.ivPlayerAvailability.backgroundColor = colours.red
        default:
            cell.ivPlayerAvailability.backgroundColor = colours.primaryGrey
        }
        
        
        if player.motm {
            cell.ivMotmAward.isHidden = false
        } else {
            cell.ivMotmAward.isHidden = true
        }
        
        
        return cell
    }
    
    @IBAction func btnScorelineTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnFixturePostcodeTapped(_ sender: Any) {
        
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let motmAction = UIContextualAction(style: .normal, title: "MOTM") { (action, view, actionPerformed) in
            
            let player = self.playerArray[indexPath.row] as! PlayerFixtureModel
            
            //Update the database with MOM (Move this out)
            let playerRef = FixtureModel.collection.child(self.teamId).child(self.fixtureId).child("players").child(player.playerId).child("motm")
            playerRef.setValue(true)
            
            //reload the xib / table
            self.tableview.reloadRows(at: [indexPath], with: .fade)
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
            actionPerformed(true)
            
        }
        motmAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [motmAction])
    }
    
    
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        print("did end editing")
    }
    
    
    
    
        
    //    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //        let paymentsAction = UIContextualAction(style: .normal, title: "Payments") { (action, view, actionPerformed) in
    //            print("Making Payment?")
    //        }
    //        paymentsAction.backgroundColor = .gray
    //        return UISwipeActionsConfiguration(actions: [paymentsAction])
    //    }
    //
    //
    //
    
}
