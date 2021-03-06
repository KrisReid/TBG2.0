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
    LoginSignupButton = "LoginSignupButton",
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
    //Share Team
    ShareTeamName = "ShareTeamName",
    ShareTeamPostcode = "ShareTeamPostcode",
    ShareTeamPIN = "ShareTeamPIN",
    ShareTeamID = "ShareTeamID",
    //Change Team PIN
    TeamPINTeamPIN = "TeamPINTeamPIN",
    TeamPINDone = "TeamPINDone",
    //Fixture
    FixturesTable = "FixturesTable",
    FixtureOpposition = "FixtureOpposition",
    FixtureHomeAway = "FixtureHomeAway",
    FixtureDateTime = "FixtureDateTime",
    FixtureHomeTeamGoals = "FixtureHomeTeamGoals",
    FixtureAwayTeamGoals = "FixtureAwayTeamGoals",
    //Fixture Information (Detail)
    FixtureDetailHomeTeamCrest = "FixtureDetailHomeTeamCrest",
    FixtureDetailAwayTeamCrest = "FixtureDetailAwayTeamCrest",
    FixtureDetailHomeTeamGoals = "FixtureDetailHomeTeamGoals",
    FixtureDetailAwayTeamGoals = "FixtureDetailAwayTeamGoals",
    FixtureDetailDate = "FixtureDetailDate",
    FixtureDetailTime = "FixtureDetailTime",
    FixtureDetailPostcode = "FixtureDetailPostcode",
    FixtureDetailGoalIcon = "FixtureDetailGoalIcon",
    FixtureDetailGoalCount = "FixtureDetailGoalCount",
    FixtureDetailMotmIcon = "FixtureDetailMotmIcon",
    FixtureDetailPlayerName = "FixtureDetailPlayerName",
    //Create Fixture
    CreateFixtureToggle = "CreateFixtureToggle",
    CreateFixtureHomeOrAway = "CreateFixtureHomeOrAway",
    CreateFixtureOpposition = "CreateFixtureOpposition",
    CreateFixtureDate = "CreateFixtureDate",
    CreateFixtureTime = "CreateFixtureTime",
    CreateFixturePostcode = "CreateFixturePostcode",
    CreateFixtureCreateGame = "CreateFixtureCreateGame",
    //Player Details
    PlayerDetailProfilePicture = "PlayerDetailProfilePicture",
    PlayerDetailPlayerName = "PlayerDetailPlayerName",
    PlayerDetailDateOfBirth = "PlayerDetailDateOfBirth",
    PlayerDetailStatsTitle = "PlayerDetailStatsTitle",
    PlayerDetailStatsGamesPlayedCount = "PlayerDetailStatsGamesPlayedCount",
    PlayerDetailStatsGamesPlayedTitle = "PlayerDetailStatsGamesPlayedTitle",
    PlayerDetailStatsGamesMOTMCount = "PlayerDetailStatsGamesMOTMCount",
    PlayerDetailStatsGamesMOTMTitle = "PlayerDetailStatsGamesMOTMTitle",
    PlayerDetailStatsGamesGoalsCount = "PlayerDetailStatsGamesGoalsCount",
    PlayerDetailStatsGamesGoalsTitle = "PlayerDetailStatsGamesGoalsTitle"
}
