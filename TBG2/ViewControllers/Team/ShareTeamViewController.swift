//
//  ShareTeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 23/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class ShareTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var titleArray: [String]! = ["Team ID","Team PIN","Share"]
    var answerArray: [String]! = ["-299fFFCJE8DJEEddf","123456"]
    
//    lazy var team: [Team] = {
//        let teamModel = TeamsModel()
//        return teamModel.teamList
//    } ()
//
//    let teamData: [Team] = TeamsModel.init().teamList
    
    @IBOutlet weak var ivTeamBadge: UIImageView!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblTeamPostcode: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var colours = Colours()
    var player: PlayerModel?
    var team: TeamModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "ShareTableViewCell", bundle: nil), forCellReuseIdentifier: "ShareTableViewCell")
        tableview.isScrollEnabled = false
        
    
//        ivTeamBadge.image = teamData[0].teamImage
//        lblTeamName.text = teamData[0].teamName
//        lblTeamPostcode.text = teamData[0].teamPostcode
        
        ivTeamBadge.circle(colour: colours.primaryBlue.cgColor)
        
        //Load Team Data
        loadTeamData()
    }
    
    
    func loadTeamData() {
        
        let userRef = PlayerModel.getUser()
        userRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let player = PlayerModel(snapshot) else {return}
            strongSelf.player = player
            
            let teamRef = TeamModel.collection.child(strongSelf.player?.teamId ?? "")
            teamRef.observe(.value) { [weak self] (snapshot) in
                guard let strongSelf = self else { return }
                guard let team = TeamModel(snapshot) else {return}
                strongSelf.team = team
                
                let image = Helper.ImageUrlConverter(url: team.crest!)
                strongSelf.ivTeamBadge.image = image.image
                
                strongSelf.lblTeamName.text = team.name
                strongSelf.lblTeamPostcode.text = team.postcode
                
                DispatchQueue.main.async {
                    strongSelf.tableview.reloadData()
                }
                
            }
            
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShareTableViewCell") as! ShareTableViewCell

        cell.lblTitle.text = titleArray[indexPath.row]

        
        if (indexPath.row == 0) {cell.lblAnswer.text = team?.id}
        let pin = team?.pin
        if (indexPath.row == 1) {cell.lblAnswer.text = pin?.description}
        if (indexPath.row == 2) {cell.ivAnswer.image = UIImage(named: "share_icon")}
//        else {cell.lblAnswer.text = answerArray[indexPath.row]}
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pin = team?.pin
        
        if indexPath.row == 1 {
            let snapshot = pin?.description
//            let snapshot = answerArray[indexPath.row]
            performSegue(withIdentifier: "teamPINSegue", sender: snapshot)
        }
        if indexPath.row == 2 {
            let firstActivityItem = "ID: \(String(team!.id)), PIN: \(String(team!.pin))"
//            let firstActivityItem = "ID: \(answerArray[0]), PIN: \(answerArray[1])"

            let activityViewController = UIActivityViewController(
                activityItems: [firstActivityItem], applicationActivities: nil)

            self.present(activityViewController, animated: true, completion: nil)

            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
            ]
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TeamPinViewController {
            if let snapshot = sender as? String {
                vc.teamPIN = snapshot
            }
        }
    }
    
}
