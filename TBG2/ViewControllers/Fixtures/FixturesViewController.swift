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
    var team: TeamModel?
    var fixtures: NSMutableArray = []
    let today = Date()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Accessability Identifiers
        setupAccessibilityAndLocalisation()
        
        tableview.estimatedRowHeight = CGFloat(70.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixturesTableViewCell", bundle: nil), forCellReuseIdentifier: "FixturesTableViewCell")
        
        //Bar Button Items
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: self, action: #selector(addFixtureTapped))
        
        //Load Data
        loadData()
        
        //Refresh Controller
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }
    
    private func setupAccessibilityAndLocalisation() {
        tableview.accessibilityIdentifier = AccessabilityIdentifier.FixturesTable.rawValue
    }
    
    @objc func refresh(_ sender: AnyObject) {
        loadData()
    }
    
    func loadData() {
        //Get the team data
        let teamRef = TeamModel.collection.child(PlayerModel.user?.teamId ?? "")
        teamRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let team = TeamModel (snapshot) else { return }
            self.team = team
        }
        
        //Get the fixture data
        let fixtureRef = FixtureModel.collection.child(PlayerModel.user?.teamId ?? "")
        let fixtureRefQuery = fixtureRef.queryOrderedByKey()

        fixtureRefQuery.observe(.value) { (snapshot) in
            self.fixtures.removeAllObjects()

            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot else { continue }
                guard let fixture = FixtureModel(snapshot) else { continue }
                self.fixtures.insert(fixture, at: 0)
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixturesTableViewCell") as! FixturesTableViewCell
        
        //Accessability Identifiers
        cell.ivHomeAway.accessibilityIdentifier = AccessabilityIdentifier.FixtureHomeAway.rawValue
        cell.lblOpposition.accessibilityIdentifier = AccessabilityIdentifier.FixtureOpposition.rawValue
        cell.lblDateTime.accessibilityIdentifier = AccessabilityIdentifier.FixtureDateTime.rawValue
        cell.lblHomeGoals.accessibilityIdentifier = AccessabilityIdentifier.FixtureHomeTeamGoals.rawValue
        cell.lblAwayGoals.accessibilityIdentifier = AccessabilityIdentifier.FixtureAwayTeamGoals.rawValue
        
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
            cell.lblOpposition.textColor = colours.primaryBlue
            cell.lblAwayGoals.text = String(fixture.teamGoals)
            cell.lblHomeGoals.text = String(fixture.oppositionGoals)
        }

        //ScoreLine Logic
        let date = Helper.stringToDate(date: fixture.date)
        if today < date {
            cell.lblAwayGoals.text = "-"
            cell.lblHomeGoals.text = "-"
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
            let teamId = PlayerModel.user?.teamId ?? ""

            let fixture = fixtures[indexPath.row] as! FixtureModel
            let fixtureId = fixture.fixtureId

            FixtureModel.deleteFixture(teamId: teamId, fixtureId: fixtureId)
        }
    }
    
    
    @objc func addFixtureTapped () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Fixtures", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFixtureViewController") as! AddFixtureViewController
        self.present(nextViewController, animated: true, completion: nil)
    }

} 
