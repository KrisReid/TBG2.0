//
//  FixtureInformationViewController.swift
//  TBG2
//
//  Created by Kris Reid on 01/03/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class FixtureInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ivHomeTeam: UIImageView!
    @IBOutlet weak var ivAwayTeam: UIImageView!
    @IBOutlet weak var lblHomeGoals: UILabel!
    @IBOutlet weak var lblAwayGoals: UILabel!
    @IBOutlet weak var lblFixtureDate: UILabel!
    @IBOutlet weak var lblFixtureTime: UILabel!
    @IBOutlet weak var lblFixturePostcode: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    let data: [Fixture] = TeamModel.init().teamList[0].fixtures
    
    var homeGoals: String = ""
    var awayGoals: String = ""
    var fixtureDate: String = ""
    var fixtureTime: String = ""
    var fixturePostcode: String = ""
    
    var colours = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblFixtureDate.text = fixtureDate
        lblFixtureTime.text = fixtureTime
        lblFixturePostcode.text = fixturePostcode
        lblHomeGoals.text = homeGoals
        lblAwayGoals.text = awayGoals
        
        ivHomeTeam.circle(colour: colours.primaryBlue.cgColor)
        ivAwayTeam.circle(colour: colours.primaryBlue.cgColor)

        tableview.estimatedRowHeight = CGFloat(50.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixtureDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FixtureDetailTableViewCell")
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureDetailTableViewCell") as! FixtureDetailTableViewCell
        
        for player in data[indexPath.row].players {
            print(player.playerName)
            cell.lblPlayerName.text = player.playerName
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
