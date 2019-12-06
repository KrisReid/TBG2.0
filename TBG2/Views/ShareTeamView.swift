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
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        ivClubBadge.layer.cornerRadius = ivClubBadge.frame.width / 2
        ivClubBadge.layer.masksToBounds = true
        ivClubBadge.layer.borderWidth = 1.0
        ivClubBadge.layer.borderColor = colours.primaryBlue.cgColor
        
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
        
        print("Index Path Selected: \(indexPath.row)")
        
        //If one of them is slected then go to a view controller
        
//        let vc = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(withIdentifier: "TeamPinViewController") as! UIViewController
//
//        UIApplication.shared.keyWindow?.rootViewController = vc
        
    }
    
}
