//
//  FixturesViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FixturesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var colours = Colours()
    var player: PlayerModel?
    var team: TeamModel?
    var fixtures: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.estimatedRowHeight = CGFloat(70.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixturesTableViewCell", bundle: nil), forCellReuseIdentifier: "FixturesTableViewCell")
        
        //Bar Button Items
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: self, action: #selector(addFixtureTapped))
        
        //Load Data
        loadData()
    }
    
    
    func loadData() {
        
        //Get the user & player data
        let userRef = PlayerModel.getUser()
        userRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let player = PlayerModel(snapshot) else {return}
            strongSelf.player = player
            
            //Get the team data
            let teamRef = TeamModel.collection.child(strongSelf.player?.teamId ?? "")
            teamRef.observe(.value) { (snapshot) in
                guard let team = TeamModel (snapshot) else { return }
                strongSelf.team = team
            }
            
            //Get the fixture data
            let fixtureRef = FixtureModel.collection.child(strongSelf.player?.teamId ?? "")
            let fixtureRefQuery = fixtureRef.queryOrderedByKey()

            fixtureRefQuery.observeSingleEvent(of: .value) { (snapshot) in
                guard let strongSelf = self else { return }
                for item in snapshot.children {
                    guard let snapshot = item as? DataSnapshot else { continue }
                    guard let fixture = FixtureModel(snapshot) else { continue }
                    strongSelf.fixtures.insert(fixture, at: 0)
                }
                DispatchQueue.main.async {
                    strongSelf.tableview.reloadData()
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixturesTableViewCell") as! FixturesTableViewCell
        
        let fixture = fixtures[indexPath.row] as! FixtureModel
        
        cell.lblOpposition.text = fixture.opposition
        cell.lblAwayGoals.text = fixture.awayGoals
        cell.lblHomeGoals.text = fixture.homeGoals
        cell.lblDateTime.text = "\(fixture.date) (\(fixture.time))"
        
        if fixture.homeFixture == true {
            cell.ivHomeAway.image = UIImage(named: "home_icon")
            cell.lblOpposition.textColor = colours.secondaryBlue
        } else {
            cell.ivHomeAway.image = UIImage(named: "away_icon")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = fixtures[indexPath.row]
        performSegue(withIdentifier: "fixtureInformationSegue", sender: snapshot)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FixtureInformationViewController {
            if let snapshot = sender as? FixtureModel {
                vc.fixtureDate = snapshot.date
                vc.fixtureTime = snapshot.time
                vc.fixturePostcode = snapshot.postcode
                vc.awayGoals = snapshot.awayGoals
                vc.homeGoals = snapshot.homeGoals
                vc.homeFixture = snapshot.homeFixture
                vc.teamCrestURL = self.team?.crest
                vc.teamId = self.team?.id ?? ""
                vc.fixtureId = snapshot.fixtureId
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print(indexPath.row)
        }
    }
    
    @objc func addFixtureTapped () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Fixtures", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFixtureViewController") as! AddFixtureViewController
        self.present(nextViewController, animated: true, completion: nil)
    }

} 
