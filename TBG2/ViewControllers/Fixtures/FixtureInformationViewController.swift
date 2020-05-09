//
//  FixtureInformationViewController.swift
//  TBG2
//
//  Created by Kris Reid on 01/03/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FixtureInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var ivHomeTeam: UIImageView!
    @IBOutlet weak var ivAwayTeam: UIImageView!
    @IBOutlet weak var lblHomeGoals: UILabel!
    @IBOutlet weak var lblAwayGoals: UILabel!
    @IBOutlet weak var lblFixtureDate: UILabel!
    @IBOutlet weak var lblFixtureTime: UILabel!
    @IBOutlet weak var lblFixturePostcode: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tfHomeGoals: UITextField!
    @IBOutlet weak var tfAwayGoals: UITextField!
    
    var teamId: String = ""
    var fixtureId: String = ""
    var opposition: String = ""
    var teamCrestURL: URL?
    var teamGoals = Int()
    var oppositionGoals = Int()
    var homeFixture: Bool = true
    var fixtureDate: String = ""
    var fixtureTime: String = ""
    var fixturePostcode: String = ""
    var playerArray: NSMutableArray = []

    var colours = Colours()
    
    var selectedGoals: String?
    let pickerData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var tempTeamGoalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Local team goals
        tempTeamGoalCount = teamGoals
        
        //Maybe do something with the date - if its before today the nshow - instead of 0?
        
        
        //Display Data
        lblFixtureDate.text = fixtureDate
        lblFixtureTime.text = fixtureTime
        lblFixturePostcode.text = fixturePostcode
        
        if homeFixture {
            lblHomeGoals.text = String(teamGoals)
            lblAwayGoals.text = String(oppositionGoals)
            tfHomeGoals.text = String(teamGoals)
            tfAwayGoals.text = String(oppositionGoals)
            tfHomeGoals.isEnabled = false
            tfAwayGoals.isEnabled = true
        } else {
            lblHomeGoals.text = String(oppositionGoals)
            lblAwayGoals.text = String(teamGoals)
            tfHomeGoals.text = String(oppositionGoals)
            tfAwayGoals.text = String(teamGoals)
            tfHomeGoals.isEnabled = true
            tfAwayGoals.isEnabled = false
        }
        
        //Styling
        ivHomeTeam.circle(colour: colours.primaryBlue.cgColor)
        ivAwayTeam.circle(colour: colours.primaryBlue.cgColor)

        //Table View
        tableview.estimatedRowHeight = CGFloat(50.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixtureDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FixtureDetailTableViewCell")
        
        //Load Player Data
        loadPlayerFixtureData()
        
        //Display Crest
        if homeFixture {
            Helper.setImageView(imageView: ivHomeTeam, url: self.teamCrestURL!)
        } else {
            Helper.setImageView(imageView: ivAwayTeam, url: self.teamCrestURL!)
        }
        
        createPickerView()
        dismissPickerView()
        
    }
    
    func loadPlayerFixtureData() {
        
        let playerFixtureRef = FixtureModel.collection.child(teamId).child(fixtureId).child("players")
        let playerFixtureRefQuery = playerFixtureRef.queryOrderedByKey()
        
        //Initial load of the array
        if self.playerArray == [] {
            playerFixtureRefQuery.observeSingleEvent(of: .value) { (snapshot) in
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

        //Keeping the DB connection open for observing child changes that can reflect in the Array
        playerFixtureRefQuery.observe(.childChanged) { (snapshot) in
            var arrayIndex = 0
            for playerObject in self.playerArray {
                let player = playerObject as! PlayerFixtureModel
                if snapshot.key == player.playerId {
                    //Convert the snapshot
                    guard let c = PlayerFixtureModel(snapshot) else { continue }
                    //Insert the snapshot
                    self.playerArray.replaceObject(at: arrayIndex, with: c)
                }
                arrayIndex += 1
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
        
        if player.goals > 0 {
            cell.lblGoalScoredCount.isHidden = false
            cell.ivGoalScored.isHidden = false
            cell.lblGoalScoredCount.text = String(player.goals)
        } else {
            cell.lblGoalScoredCount.isHidden = true
            cell.ivGoalScored.isHidden = true
        }
        
        return cell
    }
    
    @IBAction func btnFixturePostcodeTapped(_ sender: Any) {
        Helper.getLongLat(postcode: fixturePostcode, opposition: opposition)
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let player = self.playerArray[indexPath.row] as! PlayerFixtureModel
        
        //MOTM
        let motmAction = UIContextualAction(style: .normal, title: "MOTM") { (action, view, actionPerformed) in
            if player.motm {
                FixtureModel.postMotm(teamId: self.teamId, fixtureId: self.fixtureId, playerId: player.playerId, motm: false)
                PlayerModel.postMotm(playerId: player.playerId, motm: false)
                actionPerformed(true)
            } else {
                FixtureModel.postMotm(teamId: self.teamId, fixtureId: self.fixtureId, playerId: player.playerId, motm: true)
                PlayerModel.postMotm(playerId: player.playerId, motm: true)
                actionPerformed(true)
            }
        }
        motmAction.backgroundColor = player.motm ? colours.primaryGrey : colours.yellow
        motmAction.title = player.motm ? "Remove MOTM" : "MOTM"
        
        //Add Goal
        let addGoalAction = UIContextualAction(style: .normal, title: "Add Goal") { (action, view, actionPerformed) in
            FixtureModel.postPlayerGoals(teamId: self.teamId, fixtureId: self.fixtureId, playerId: player.playerId, goal: true)
            PlayerModel.postPlayerGoals(playerId: player.playerId, goal: true)
            
            self.tempTeamGoalCount += 1
            if self.homeFixture {
                self.lblHomeGoals.text = String(self.tempTeamGoalCount)
                self.tfHomeGoals.text = String(self.tempTeamGoalCount)
            } else {
                self.lblAwayGoals.text = String(self.tempTeamGoalCount)
                self.tfAwayGoals.text = String(self.tempTeamGoalCount)
            }
            actionPerformed(true)
        }
        addGoalAction.backgroundColor = colours.primaryBlue
        
        //Minus Goal
        let minusGoalAction = UIContextualAction(style: .normal, title: "Minus Goal") { (action, view, actionPerformed) in
            if player.goals >= 1 {
                FixtureModel.postPlayerGoals(teamId: self.teamId, fixtureId: self.fixtureId, playerId: player.playerId, goal: false)
                PlayerModel.postPlayerGoals(playerId: player.playerId, goal: false)
                self.tempTeamGoalCount -= 1
                if self.homeFixture {
                    self.lblHomeGoals.text = String(self.tempTeamGoalCount)
                    self.tfHomeGoals.text = String(self.tempTeamGoalCount)
                } else {
                    self.lblAwayGoals.text = String(self.tempTeamGoalCount)
                    self.tfAwayGoals.text = String(self.tempTeamGoalCount)
                }
                actionPerformed(true)
            } else {
                actionPerformed(false)
            }
        }
        minusGoalAction.backgroundColor = colours.secondaryBlue
        
        let swipeAction = UISwipeActionsConfiguration(actions: [minusGoalAction, addGoalAction, motmAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let paymentsAction = UIContextualAction(style: .normal, title: "Payments") { (action, view, actionPerformed) in
            print("Making Payment?")
        }
        paymentsAction.backgroundColor = .gray
        return UISwipeActionsConfiguration(actions: [paymentsAction])
    }
    
    
    
    
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        tfHomeGoals.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(action))
        toolBar.tintColor = colours.primaryBlue
        toolBar.backgroundColor = colours.primaryGrey
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        tfHomeGoals.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    //MARK:- PickerView Delegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGoals = pickerData[row]
        tfHomeGoals.text = selectedGoals
    }
    

    
    
    
}
