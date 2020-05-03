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
        
        return cell
    }
    
    @IBAction func btnScorelineTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnFixturePostcodeTapped(_ sender: Any) {
        
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let motmAction = UIContextualAction(style: .normal, title: "MOTM") { (action, view, actionPerformed) in
//
//            // INSIDE THE CLICK
//
//            actionPerformed(true)
//        }
//        motmAction.backgroundColor = .yellow
//
//        return UISwipeActionsConfiguration(actions: [motmAction])
//    }
    
    
    
    
    
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let flagAction = self.contextualToggleFlagAction(forRowAtIndexPath: indexPath)
//        let swipeConfig = UISwipeActionsConfiguration(actions: [flagAction])
//        return swipeConfig
//    }
    
    
//    func contextualToggleFlagAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
//        // 1
//        var data = data[indexPath.row]
//        // 2
//        let action = UIContextualAction(style: .normal,
//                                        title: "Flag") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
//            // 3
//            if email.toggleFlaggedFlag() {
//                // 4
//                self.data[indexPath.row] = email
//                self.tableview.reloadRows(at: [indexPath], with: .none)
//                // 5
//                completionHandler(true)
//            } else {
//                // 6
//                completionHandler(false)
//            }
//        }
//        // 7
//        action.title = "Flag"
////        action.image = UIImage(named: "flag")
//        action.backgroundColor = email.isFlagged ? UIColor.gray : UIColor.orange
//        return action
//    }
    
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let paymentsAction = UIContextualAction(style: .normal, title: "Payments") { (action, view, actionPerformed) in
//            print("Making Payment?")
//        }
//        motmAction.backgroundColor = .yellow
//        return UISwipeActionsConfiguration(actions: [paymentsAction])
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print("did end editing")
        guard let indexPath = indexPath else {return}
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func setCell(color:UIColor, at indexPath: IndexPath){
        let cell = tableview.cellForRow(at: indexPath )
        cell?.backgroundColor = color
    }
}
