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
    
    lazy var team: [Team] = {
        let teamModel = TeamModel()
        return teamModel.teamList
    } ()

    let teamData: [Team] = TeamModel.init().teamList
    
    @IBOutlet weak var ivTeamBadge: UIImageView!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblTeamPostcode: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var colours = Colours()
    var circles = Circles()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "ShareTableViewCell", bundle: nil), forCellReuseIdentifier: "ShareTableViewCell")
        tableview.isScrollEnabled = false
    
        ivTeamBadge.image = teamData[0].teamImage
        lblTeamName.text = teamData[0].teamName
        lblTeamPostcode.text = teamData[0].teamPostcode
        
        circles.circles(name: ivTeamBadge, colour: colours.primaryBlue.cgColor)

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
        
        if (indexPath.row == 2) {cell.ivAnswer.image = UIImage(named: "share_icon")}
        else {cell.lblAnswer.text = answerArray[indexPath.row]}
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let snapshot = answerArray[indexPath.row]
            print("snapshot for segue: \(snapshot)")
//            performSegue(withIdentifier: "playerDetailSegue", sender: snapshot)
        }
        if indexPath.row == 2 {
            print("IndexPath 2 !!!!!!")
            
            let firstActivityItem = "ID: \(answerArray[0]), PIN: \(answerArray[1])"

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

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? PlayerDetailViewController {
//            if let snapshot = sender as? Player {
//                vc.playerName = snapshot.playerName
//                vc.playerProfilePic = snapshot.playerImage
//                vc.playerAge = snapshot.playerAge
//                vc.playerPosition = snapshot.playerPostion
//            }
//        }
//    }
    
}
