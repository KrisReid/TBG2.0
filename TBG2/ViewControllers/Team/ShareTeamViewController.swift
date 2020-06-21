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
    
    @IBOutlet weak var ivTeamBadge: UIImageView!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblTeamPostcode: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var colours = Colours()
    var player: PlayerModel?
    var team: TeamModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Table View
        tableview.register(UINib(nibName: "ShareTableViewCell", bundle: nil), forCellReuseIdentifier: "ShareTableViewCell")
        tableview.isScrollEnabled = false
        
        //Styling
        ivTeamBadge.circle(colour: colours.primaryBlue.cgColor)
        
        //Load Team Data
        loadTeamData()
        
        //Accessability Identifiers
        setupAccessibilityAndLocalisation()
    }
    
    private func setupAccessibilityAndLocalisation() {
        lblTeamName.accessibilityIdentifier = AccessabilityIdentifier.TeamName.rawValue
        lblTeamPostcode.accessibilityIdentifier = AccessabilityIdentifier.TeamPostcode.rawValue
    }
    
    
    func loadTeamData() {
        let spinner = UIViewController.displayLoading(withView: self.view)
        
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

                
                Helper.setImageView(imageView: strongSelf.ivTeamBadge, url: team.crest!)
                
//                //Manual delay code
//                let seconds = 0.3
//                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//                    // Put your code which should be executed with a delay here
//                    strongSelf.ivTeamBadge.image = image.image
//                }
                
                strongSelf.lblTeamName.text = team.name
                strongSelf.lblTeamPostcode.text = team.postcode
                
                DispatchQueue.main.async {
                    strongSelf.tableview.reloadData()
                    UIViewController.removeLoading(spinner: spinner)
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
        if (indexPath.row == 1) {cell.lblAnswer.text = team?.pin.description}
        if (indexPath.row == 2) {cell.ivAnswer.image = UIImage(named: "share_icon")}
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            performSegue(withIdentifier: "teamPINSegue", sender: team!)
        }
        if indexPath.row == 2 {
            let firstActivityItem = "ID: \(String(team!.id)), PIN: \(String(team!.pin))"

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
            if let snapshot = sender as? TeamModel {
                vc.teamPIN = snapshot.pin
                vc.teamId = snapshot.id
            }
        }
    }
    
}
