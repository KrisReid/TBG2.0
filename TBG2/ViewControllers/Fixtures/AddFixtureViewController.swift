//
//  AddFixtureViewController.swift
//  TBG2
//
//  Created by Kris Reid on 29/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddFixtureViewController: UIViewController {
    
    @IBOutlet weak var scHomeAway: UISegmentedControl!
    @IBOutlet weak var tfOpposition: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var tfPostcode: UITextField!
    @IBOutlet weak var ivManagerAvailability: UIImageView!
    @IBOutlet weak var ivAssistantAvailability: UIImageView!
    @IBOutlet weak var btnManager: UIButton!
    @IBOutlet weak var btnAssistant: UIButton!
    @IBOutlet weak var btnCreateGame: UIButton!
    @IBOutlet weak var svStackView: UIStackView!
    @IBOutlet weak var vManager: UIView!
    @IBOutlet weak var vAssistantManager: UIView!
    
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    
    var colour = Colours()
    var player: PlayerModel?
    var players: NSMutableArray = []
    var ManagerAvailability = false
    var AssistantAvailability = false
    var managerId: String = ""
    var assistantManagerId: String = ""
    var HomeFixture = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Accessability Identifiers
        setupAccessibilityAndLocalisation()
        
        //Hide Manager & Assistant
        vManager.isHidden = true
        vAssistantManager.isHidden = true
        
        //Styling
        tfOpposition.underlined(colour: Colours.init().secondaryBlue.cgColor)
        tfDate.underlined(colour: Colours.init().secondaryBlue.cgColor)
        tfTime.underlined(colour: Colours.init().secondaryBlue.cgColor)
        tfPostcode.underlined(colour: Colours.init().secondaryBlue.cgColor)
        btnManager.circle(colour: colour.secondaryBlue.cgColor)
        ivManagerAvailability.circle(colour: colour.secondaryBlue.cgColor)
        btnAssistant.circle(colour: colour.secondaryBlue.cgColor)
        ivAssistantAvailability.circle(colour: colour.secondaryBlue.cgColor)
        btnCreateGame.baseStyle()
        
        //Segmented Control
        scHomeAway.defaultSegmentedControlFormat(backgroundColour: colour.secondaryBlue)
        
        //Date Picker
        datePicker = UIDatePicker()
        datePicker?.standardDatePicker(datePicker: datePicker!)
        datePicker?.addTarget(self, action: #selector(AddFixtureViewController.dateChanged(datePicker:)), for: .valueChanged)
        tfDate.inputView = datePicker
        
        //TimePicker
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.minuteInterval = 15
        timePicker?.frame.size.height = 250
        timePicker?.backgroundColor = UIColor.white
        timePicker?.addTarget(self, action: #selector(AddFixtureViewController.timeChanged(timePicker:)), for: .valueChanged)
        tfTime.inputView = timePicker
        
        //Load Players Data
        loadPlayersData()
        
    }

//    MISSING ACCESABILITY ????
//    @IBOutlet weak var ivManagerAvailability: UIImageView!
//    @IBOutlet weak var ivAssistantAvailability: UIImageView!
//    @IBOutlet weak var btnManager: UIButton!
//    @IBOutlet weak var btnAssistant: UIButton!
    

    private func setupAccessibilityAndLocalisation() {
        scHomeAway.accessibilityIdentifier = AccessabilityIdentifier.CreateFixtureHomeOrAway.rawValue
        tfOpposition.accessibilityIdentifier = AccessabilityIdentifier.CreateFixtureOpposition.rawValue
        tfDate.accessibilityIdentifier = AccessabilityIdentifier.CreateFixtureDate.rawValue
        tfTime.accessibilityIdentifier = AccessabilityIdentifier.CreateFixtureTime.rawValue
        tfPostcode.accessibilityIdentifier = AccessabilityIdentifier.CreateFixturePostcode.rawValue
        btnCreateGame.accessibilityIdentifier = AccessabilityIdentifier.CreateFixtureCreateGame.rawValue
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        datePicker.standardDateFormat(datePicker: datePicker, textField: tfDate)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        tfTime.text = timeFormatter.string(from: timePicker.date)
    }
    
    @IBAction func scHomeAwayTapped(_ sender: Any) {
        if scHomeAway.selectedSegmentIndex == 0 {
            HomeFixture = true
        } else {
            HomeFixture = false
        }
    }
    
    @IBAction func btnManagerTapped(_ sender: Any) {
        self.view.endEditing(true)
        if ManagerAvailability {
            ivManagerAvailability.backgroundColor = UIColor.systemRed
            ManagerAvailability = false
        } else {
            ivManagerAvailability.backgroundColor = UIColor.systemGreen
            ManagerAvailability = true
        }
    }
    
    @IBAction func btnAssistantTapped(_ sender: Any) {
        self.view.endEditing(true)
        if AssistantAvailability {
            ivAssistantAvailability.backgroundColor = UIColor.systemRed
            AssistantAvailability = false
        } else {
            ivAssistantAvailability.backgroundColor = UIColor.systemGreen
            AssistantAvailability = true
        }
    }
    
    func loadPlayersData() {
        let userRef = PlayerModel.getUser()
        userRef.observe(.value) { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let player = PlayerModel(snapshot) else {return}
            strongSelf.player = player
            
            let playerRef = TeamModel.getTeamPlayers(teamId: player.teamId)
            let playerRefQuery = playerRef.queryOrderedByKey()

            playerRefQuery.observeSingleEvent(of: .value) { (snapshot) in
                
                guard let strongSelf = self else { return }
                for item in snapshot.children {
                    guard let snapshot = item as? DataSnapshot else { continue }
                    guard let player = PlayerModel(snapshot) else { continue }
                    
                    //Load the players keys into an array
                    strongSelf.players.insert(snapshot.key, at: 0)
                    
                    //Load the manager as an optional player for the game
                    if player.manager {
                        strongSelf.managerId = player.id
                        if (player.playerManager) {
                            strongSelf.vManager.isHidden = false
                            let image = Helper.ImageUrlConverter(url: player.profilePictureUrl!)
                            strongSelf.btnManager.setBackgroundImage(image.image, for: .normal)
                        }
                    }
                    
                    //Load the assistant manager as an optional player for the game
                    if player.assistantManager {
                        strongSelf.assistantManagerId = player.id
                        if (player.playerManager) {
                            strongSelf.vAssistantManager.isHidden = false
                            let image = Helper.ImageUrlConverter(url: player.profilePictureUrl!)
                            strongSelf.btnAssistant.setBackgroundImage(image.image, for: .normal)
                        }
                    }
                }
            }
        }
    }

    @IBAction func btnCreateGameTapped(_ sender: Any) {

        guard let opposition = tfOpposition.text else { return }
        guard let date = tfDate.text else { return }
        guard let time = tfTime.text else { return }
        guard let postcode = tfPostcode.text else { return }
        guard let teamId = player?.teamId else { return }
        
        if (opposition == "" || date == "" || time == "" || postcode == "") {
            
            let alert = Helper.errorAlert(title: "Ooops", message: "All fields must be populated to create a game")
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            let spacelessPostcode = Helper.removeSpaces(text: postcode)
            
            FixtureModel.postFixture(teamId: teamId, homeFixture: self.HomeFixture, opposition: opposition, date: date, time: time, postcode: spacelessPostcode, playerIds: players, managerAvailability: self.ManagerAvailability, managerId: self.managerId, assistantManagerAvailability: self.AssistantAvailability, assistantManagerId: self.assistantManagerId)

            self.dismiss(animated: true, completion: nil)
        }

    }
    
    //closes the keyboard when you touch white space
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
