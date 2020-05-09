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
        
        // OBSERVE ANY FIXTURE CHANGES (ESPECIALLY TO GOAL SCORING)
        
        //Get the user & player data
        let userRef = PlayerModel.getUser()
        userRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let player = PlayerModel(snapshot) else {return}
            strongSelf.player = player
//            userRef.removeAllObservers()
            
            //Get the team data
            let teamRef = TeamModel.collection.child(strongSelf.player?.teamId ?? "")
            teamRef.observe(.value) { (snapshot) in
                print("4444444444")
                guard let team = TeamModel (snapshot) else { return }
                strongSelf.team = team
                strongSelf.team = team
            }
            
            //Get the fixture data
            let fixtureRef = FixtureModel.collection.child(strongSelf.player?.teamId ?? "")
            let fixtureRefQuery = fixtureRef.queryOrderedByKey()

            if strongSelf.fixtures == [] {
                fixtureRefQuery.observeSingleEvent(of: .value) { (snapshot) in
                    print("555555555555")
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
            } else {
                fixtureRefQuery.observeSingleEvent(of: .childAdded) { (snapshot) in
//                    guard let strongSelf = self else { return }
                    var arrayIndex = 0
                    for fixtureObject in strongSelf.fixtures {
                        let fixture = fixtureObject as! FixtureModel
                        if snapshot.key == fixture.fixtureId {
                            //Convert the snapshot
                            guard let f = FixtureModel(snapshot) else { continue }
                            //Insert the snapshot
                            self?.fixtures.replaceObject(at: arrayIndex, with: f)
                        }
                        arrayIndex += 1
                    }
                    DispatchQueue.main.async {
                        strongSelf.tableview.reloadData()
                    }
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
        cell.lblDateTime.text = "\(fixture.date) (\(fixture.time))"
        
        if fixture.homeFixture {
            cell.ivHomeAway.image = UIImage(named: "home_icon")
            cell.lblOpposition.textColor = colours.secondaryBlue
            cell.lblAwayGoals.text = String(fixture.oppositionGoals)
            cell.lblHomeGoals.text = String(fixture.teamGoals)
        } else {
            cell.ivHomeAway.image = UIImage(named: "away_icon")
            cell.lblAwayGoals.text = String(fixture.teamGoals)
            cell.lblHomeGoals.text = String(fixture.oppositionGoals)
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
                vc.oppositionGoals = snapshot.oppositionGoals
                vc.teamGoals = snapshot.teamGoals
                vc.homeFixture = snapshot.homeFixture
                vc.teamCrestURL = self.team?.crest
                vc.teamId = self.team?.id ?? ""
                vc.fixtureId = snapshot.fixtureId
                vc.opposition = snapshot.opposition
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
