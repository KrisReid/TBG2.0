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
    //Login
    LoginEmail = "LoginEmail",
    LoginPassword = "LoginPassword",
    LoginButton = "LoginButton",
    LogininSignupButton = "LogininSignupButton",
    //Signup
    SignupProfileButton = "SignupProfileButton",
    SignupFullName = "SignupFullName",
    SignupEmailAddress = "SignupEmailAddress",
    SignupPassword = "SignupPassword",
    SignupDOB = "SignupDOB",
    SignupHouseNumber = "SignupHouseNumber",
    SignupPostcode = "SignupPostcode",
    SignupCreateTeamButton = "SignupCreateTeamButton",
    SignupJoinTeamButton = "SignupJoinTeamButton",
    //CreateTeam
    CreateTeamCrestButton = "CreateTeamCrestButton",
    CreateTeamName = "CreateTeamName",
    CreateTeamPIN = "CreateTeamPIN",
    CreateTeamPostcode = "CreateTeamPostcode",
    CreateTeamSubmitButton = "CreateTeamSubmitButton",
    //Join Team
    JoinTeamId = "JoinTeamId",
    joinTeamPIN = "joinTeamPIN",
    joinTeamSubmitButton = "joinTeamSubmitButton",
        
    //Not Sure
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
    Motm = "Motm",
    //Fixture Information
    FixtureOpposition = "Opposition",
    FixtureHomeAway = "Home or Away",
    FixtureDateTime = "Fixture Date and Time",
    HomeTeamGoals = "Home Team Goals",
    AwayTeamGoals = "Away Team Goals"
}
