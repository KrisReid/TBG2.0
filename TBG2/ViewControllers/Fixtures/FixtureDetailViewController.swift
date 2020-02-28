//
//  FixtureDetailViewController.swift
//  TBG2
//
//  Created by Kris Reid on 19/01/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit

class FixtureDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var vScore: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var result: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.estimatedRowHeight = CGFloat(50.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "FixtureDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FixtureDetailTableViewCell")
        
        
        //instantiate the Xib
        let xibview = UINib(nibName: "Score", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Score
        
        //Xib Code
        xibview.frame = CGRect(x: vScore.bounds.origin.x, y: vScore.bounds.origin.y , width: UIScreen.main.bounds.width, height: vScore.bounds.height)
        vScore.addSubview(xibview)
        
        xibview.lblScore.text = result
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureDetailTableViewCell") as! FixtureDetailTableViewCell
        return cell
    }
    
    // What is the current state of the cell
    
    var motmIdentified = false
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let motmAction = UIContextualAction(style: .normal, title: "MOTM") { (action, view, actionPerformed) in
            
            if (self.motmIdentified) {
                self.setCell(color: .clear, at: indexPath)
                self.motmIdentified = false
                print(self.motmIdentified)
                actionPerformed(true)
            } else{
                self.setCell(color: .yellow, at: indexPath)
                self.motmIdentified = true
                print(self.motmIdentified)
                actionPerformed(true)
            }
        }
        motmAction.backgroundColor = .yellow
        return UISwipeActionsConfiguration(actions: [motmAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let paymentsAction = UIContextualAction(style: .normal, title: "Payments") { (action, view, actionPerformed) in
            print("Making Payment?")
        }
        return UISwipeActionsConfiguration(actions: [paymentsAction])
    }
    
    
    func setCell(color:UIColor, at indexPath: IndexPath){
//        self.view.backgroundColor = color
        let cell = tableview.cellForRow(at: indexPath )
        cell?.backgroundColor = color
    }
    

}
