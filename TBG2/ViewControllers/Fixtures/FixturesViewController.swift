//
//  FixturesViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class FixturesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
     var colours = Colours()
    
    lazy var team: [Team] = {
        let teamModel = TeamModel()
        return teamModel.teamList
    } ()

    let teamData: [Team] = TeamModel.init().teamList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.estimatedRowHeight = CGFloat(70.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixturesTableViewCell", bundle: nil), forCellReuseIdentifier: "FixturesTableViewCell")
        
        
        //Bar Button Items
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: self, action: #selector(addFixtureTapped))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamData[0].fixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixturesTableViewCell") as! FixturesTableViewCell
        
        
        cell.lblOpposition.text = teamData[0].fixtures[indexPath.row].opposition
        
        if teamData[0].fixtures[indexPath.row].homeFixture == true {
            cell.ivHomeAway.image = UIImage(named: "home_icon")
            cell.lblOpposition.textColor = colours.secondaryBlue
        } else {
            cell.ivHomeAway.image = UIImage(named: "away_icon")
        }
        
        cell.lblHomeGoals.text = teamData[0].fixtures[indexPath.row].homeGoals
        cell.lblAwayGoals.text = teamData[0].fixtures[indexPath.row].awayGoals
        
        let timeDate = "\(teamData[0].fixtures[indexPath.row].date) (\(teamData[0].fixtures[indexPath.row].time))"
        cell.lblDateTime.text = timeDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = teamData[0].fixtures[indexPath.row]
        performSegue(withIdentifier: "fixtureInformationSegue", sender: snapshot)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FixtureInformationViewController {
            if let snapshot = sender as? Fixture {
                vc.fixtureDate = snapshot.date
                vc.fixtureTime = snapshot.time
                vc.fixturePostcode = snapshot.postcode
                vc.awayGoals = snapshot.awayGoals
                vc.homeGoals = snapshot.homeGoals
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print(indexPath.row)
        }
    }
    
    @objc func addFixtureTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Fixtures", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFixtureViewController") as! AddFixtureViewController
        self.present(nextViewController, animated: true, completion: nil)
    }

}