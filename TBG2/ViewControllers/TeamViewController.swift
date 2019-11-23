//
//  TeamViewController.swift
//  TBG2
//
//  Created by Kris Reid on 03/11/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    lazy var players: [Player] = {
        let model = PlayersModel()
        return model.playerList
    } ()
    
    let sectionTitles: [String] = ["Goalkeepers","Defenders","Midfielders","Strikers"]
    
    let s1Data: [Player] = PlayersModel.init().goalkeeperList
    let s2Data: [Player] = PlayersModel.init().defenderList
    let s3Data: [Player] = PlayersModel.init().midfielderList
    let s4Data: [Player] = PlayersModel.init().strikerList

    var sectionData: [Int: [Player]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupCard()
        
        sectionData = [0 : s1Data, 1 : s2Data, 2 : s3Data, 3 : s4Data]

        tableview.estimatedRowHeight = CGFloat(74.0)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
        
        var rightBarItemImage = UIImage(named: "plus_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightBarItemImage, style: .plain, target: self, action: #selector(shareTeamInformationTapped))
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
                view.backgroundColor = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 )

        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.frame = CGRect(x: 10, y: 0, width: 100, height: 40)
        label.textColor = UIColor.white
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell

        cell.lblPlayerName.text = sectionData[indexPath.section]![indexPath.row].playerName
        cell.ivPlayerImage.image = sectionData[indexPath.section]![indexPath.row].playerImage
        
        return cell
        
    }
    
    
    
    
    @objc func shareTeamInformationTapped() {
        print("Clicked")
        
        
    }
    
//
//
//    enum CardState {
//           case collapsed
//           case expanded
//       }
//
//       // Variable determines the next state of the card expressing that the card starts and collapased
//       var nextState:CardState {
//           return cardVisible ? .collapsed : .expanded
//       }
//
//       // Variable for card view controller
//       var cardViewController:ShareTeamFormViewController!
//
//       // Variable for effects visual effect view
//       var visualEffectView:UIVisualEffectView!
//
//       // Starting and end card heights will be determined later
//       var endCardHeight:CGFloat = 0
//       var startCardHeight:CGFloat = 0
//
//       // Current visible state of the card
//       var cardVisible = false
//
//       // Empty property animator array
//       var runningAnimations = [UIViewPropertyAnimator]()
//       var animationProgressWhenInterrupted:CGFloat = 0
//
//
//       func setupCard() {
//           // Setup starting and ending card height
//           endCardHeight = self.view.frame.height * 0.5
//           startCardHeight = self.view.frame.height * 0.2
//
//           // Add Visual Effects View
//           visualEffectView = UIVisualEffectView()
//           visualEffectView.frame = self.view.frame
//           self.view.addSubview(visualEffectView)
//
//            //Add CardViewController xib to the bottom of the screen, clipping bounds so that the corners can be rounded
//           cardViewController = ShareTeamFormViewController(nibName:"ShareTeamFormViewController", bundle:nil)
//           self.view.addSubview(cardViewController.view)
//           cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - startCardHeight, width: self.view.bounds.width, height: endCardHeight)
//           cardViewController.view.clipsToBounds = true
//
//           // Add tap and pan recognizers
////           let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TeamViewController.handleCardTap(recognzier:)))
//           let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(TeamViewController.handleCardPan(recognizer:)))
//
////           cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
//           cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
//       }
//
//       // Handle tap gesture recognizer
//       @objc
//       func handleCardTap(recognzier:UITapGestureRecognizer) {
//           switch recognzier.state {
//               // Animate card when tap finishes
//           case .ended:
//               animateTransitionIfNeeded(state: nextState, duration: 0.9)
//           default:
//               break
//           }
//       }
//
//       // Handle pan gesture recognizer
//       @objc
//       func handleCardPan (recognizer:UIPanGestureRecognizer) {
//           switch recognizer.state {
//           case .began:
//               // Start animation if pan begins
//               startInteractiveTransition(state: nextState, duration: 0.9)
//
//           case .changed:
//               // Update the translation according to the percentage completed
//               let translation = recognizer.translation(in: self.cardViewController.handleArea)
//               var fractionComplete = translation.y / endCardHeight
//               fractionComplete = cardVisible ? fractionComplete : -fractionComplete
//               updateInteractiveTransition(fractionCompleted: fractionComplete)
//           case .ended:
//               // End animation when pan ends
//               continueInteractiveTransition()
//           default:
//               break
//           }
//       }
//
//
//       // Animate transistion function
//        func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
//            // Check if frame animator is empty
//            if runningAnimations.isEmpty {
//                // Create a UIViewPropertyAnimator depending on the state of the popover view
//                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                    switch state {
//                    case .expanded:
//                        // If expanding set popover y to the ending height and blur background
//                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
//                        self.visualEffectView.effect = UIBlurEffect(style: .dark)
//
//                    case .collapsed:
//                        // If collapsed set popover y to the starting height and remove background blur
//                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.startCardHeight
//
//                        self.visualEffectView.effect = nil
//                    }
//                }
//
//                // Complete animation frame
//                frameAnimator.addCompletion { _ in
//                    self.cardVisible = !self.cardVisible
//                    self.runningAnimations.removeAll()
//                }
//
//                // Start animation
//                frameAnimator.startAnimation()
//
//                // Append animation to running animations
//                runningAnimations.append(frameAnimator)
//
//                // Create UIViewPropertyAnimator to round the popover view corners depending on the state of the popover
//                let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
//                    switch state {
//                    case .expanded:
//                        // If the view is expanded set the corner radius to 30
//                        self.cardViewController.view.layer.cornerRadius = 30
//
//                    case .collapsed:
//                        // If the view is collapsed set the corner radius to 0
//                        self.cardViewController.view.layer.cornerRadius = 0
//                    }
//                }
//
//                // Start the corner radius animation
//                cornerRadiusAnimator.startAnimation()
//
//                // Append animation to running animations
//                runningAnimations.append(cornerRadiusAnimator)
//
//            }
//        }
//
//        // Function to start interactive animations when view is dragged
//        func startInteractiveTransition(state:CardState, duration:TimeInterval) {
//
//            // If animation is empty start new animation
//            if runningAnimations.isEmpty {
//                animateTransitionIfNeeded(state: state, duration: duration)
//            }
//
//            // For each animation in runningAnimations
//            for animator in runningAnimations {
//                // Pause animation and update the progress to the fraction complete percentage
//                animator.pauseAnimation()
//                animationProgressWhenInterrupted = animator.fractionComplete
//            }
//        }
//
//        // Funtion to update transition when view is dragged
//        func updateInteractiveTransition(fractionCompleted:CGFloat) {
//            // For each animation in runningAnimations
//            for animator in runningAnimations {
//                // Update the fraction complete value to the current progress
//                animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
//            }
//        }
//
//        // Function to continue an interactive transisiton
//        func continueInteractiveTransition (){
//            // For each animation in runningAnimations
//            for animator in runningAnimations {
//                // Continue the animation forwards or backwards
//                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//            }
//        }
//
//
    
}
