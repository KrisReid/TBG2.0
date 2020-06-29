//
//  AccessabilityIdentifier.swift
//  TBG2
//
//  Created by Kris Reid on 21/06/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import Foundation

enum AccessabilityIdentifier: String {
    case
    TeamName = "Team Name",
    TeamPostcode = "Team Postcode",
    TeamPIN = "Team PIN",
    TeamID = "Team ID",
    ShareTeamPIN = "Share Team PIN",
    FixturesTable = "Fixtures Table",
    //Fixture Information (Detail)
    HomeTeamCrest = "Home Team Crest",
    AwayTeamCrest = "Away Team Crest",
    DetailHomeTeamGoals = "Detail Home Team Goals",
    DetailAwayTeamGoals = "Detail Away Team Goals",
    FixtureDetailDate = "Fixture Detail Date",
    FixtureDetailTime = "Fixture Detail Time",
    FixtureDetailPostcode = "Fixture Detail Postcode",
    GoalIcon = "GoalIcon",
    Motm = "MOTM",
    //Fixture Information
    FixtureOpposition = "Opposition",
    FixtureHomeAway = "Home or Away",
    FixtureDateTime = "Fixture Date and Time",
    HomeTeamGoals = "Home Team Goals",
    AwayTeamGoals = "Away Team Goals"
}
