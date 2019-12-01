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

class ShareTeamView: UIView {

    @IBOutlet weak var ivClubBadge: UIImageView!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblClubPostcode: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        ivClubBadge.layer.cornerRadius = ivClubBadge.frame.width / 2
        ivClubBadge.layer.masksToBounds = true
        ivClubBadge.layer.borderWidth = 1.0
        ivClubBadge.layer.borderColor = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 ).cgColor
        
        
        tableView.isScrollEnabled = false
        tableView.register(ShareTeamTableViewCell.self, forCellReuseIdentifier: "ShareTeamTableViewCell")
    }
    
}


extension UIView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShareTeamTableViewCell") as? ShareTeamTableViewCell else {fatalError("Unable to deque cell")}
        
        cell.lblOption.text = titleArray[indexPath.row]
        
        //UPDATE HERE
        if (indexPath.row == 2) {cell.ivAnswer.image = UIImage(named: "share_icon")}
        else {cell.lblAnswer.text = answerArray[indexPath.row]}
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
