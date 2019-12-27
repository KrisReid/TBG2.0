//
//  ShareTeamView.swift
//  TBG2
//
//  Created by Kris Reid on 24/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit


var titleArray: [String]! = ["Team ID","Team PIN","Share"]
var answerArray: [String]! = ["-299fFFCJE8DJEEddf","123456"]

class ShareTeamView: UIView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ivClubBadge: UIImageView!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblClubPostcode: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var colours = Colours()
    var circles = Circles()
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        circles.circles(name: ivClubBadge, colour: colours.primaryBlue.cgColor)
        
        tableView.isScrollEnabled = false
        tableView.register(ShareTeamTableViewCell.self, forCellReuseIdentifier: "ShareTeamTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShareTeamTableViewCell") as? ShareTeamTableViewCell else {fatalError("Unable to deque cell")}
        
        cell.lblOption.text = titleArray[indexPath.row]
        
        if (indexPath.row == 2) {cell.ivAnswer.image = UIImage(named: "share_icon")}
        else {cell.lblAnswer.text = answerArray[indexPath.row]}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            //ALLOW CHNGE HERE
//            print("Index Path Selected: \(indexPath.row)")
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "TeamPinViewController", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TeamPinViewController") as! TeamPinViewController

        }
        
        if indexPath.row == 2 {
            print("Index Path Selected: \(indexPath.row)")
//            let firstActivityItem = "Banananananaa"
//
//            let activityViewController = UIActivityViewController(
//                activityItems: [firstActivityItem], applicationActivities: nil)
//
//            self.present(activityViewController, animated: true, completion: nil)
//
//
//            // Anything you want to exclude
//            activityViewController.excludedActivityTypes = [
//                UIActivity.ActivityType.postToWeibo,
//                UIActivity.ActivityType.print,
//                UIActivity.ActivityType.assignToContact,
//                UIActivity.ActivityType.saveToCameraRoll,
//                UIActivity.ActivityType.addToReadingList,
//                UIActivity.ActivityType.postToFlickr,
//                UIActivity.ActivityType.postToVimeo,
//                UIActivity.ActivityType.postToTencentWeibo
//            ]

        }
                
    }
    
}
