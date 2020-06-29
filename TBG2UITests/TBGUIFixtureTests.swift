//
//  TBGUIFixtureTests.swift
//  TBG2UITests
//
//  Created by Kris Reid on 27/06/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import XCTest

class TBGUIFixtureTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        let email = "automated_tester_1@tbg.com"
        let password = "123456789"

        let app = XCUIApplication()
        app.launch()

        let emailAddressTextField = app.textFields["Email Address"]
        emailAddressTextField.tap()
        emailAddressTextField.typeText(email)

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(password)

        app.buttons["Login"].tap()

        let tabBarsQuery = app.tabBars
        let teamTab = tabBarsQuery.children(matching: .button).element(boundBy: 0)

        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: teamTab, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func tearDownWithError() throws {
        let app = XCUIApplication()
        let tabBarsQuery = XCUIApplication().tabBars
        let button = tabBarsQuery.children(matching: .button).element(boundBy: 2)
        button.tap()
        app.tables.staticTexts["Sign Out"].tap()
    }
    
    func test01FixtureTableExists() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.children(matching: .button).element(boundBy: 1).tap()
    
        XCTAssertTrue(app.tables[AccessabilityIdentifier.FixturesTable.rawValue].exists)
        XCTAssertTrue(app.navigationBars["TBG2.FixturesView"].buttons["plus icon"].exists)
        
    }
    
    func test02btnCreateGameTapped() {
        let app = XCUIApplication()
        
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.navigationBars["TBG2.FixturesView"].buttons["plus icon"].tap()
        
        app.buttons["Away"].tap()
        app.textFields["Opposition"].tap()
        app.textFields["Opposition"].typeText("Test Opposition 4")
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("29 May 2020")
        let timeTextField = app.textFields["Time"]
        timeTextField.tap()
        timeTextField.typeText("3:30 PM")
        app.textFields["Venue's Postcode"].tap()
        app.textFields["Venue's Postcode"].typeText("BS11 0BT")
        app.buttons["Create Game"].tap()
    }

    
    func test03FixtureDetailExists() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.tables[AccessabilityIdentifier.FixturesTable.rawValue].staticTexts["Test Opposition 4"].tap()
        
        XCTAssert(app.images["Home Team Crest"].exists)
        XCTAssert(app.images["Away Team Crest"].exists)
        XCTAssert(app.textFields["Detail Home Team Goals"].exists)
        XCTAssert(app.textFields["Detail Away Team Goals"].exists)
        XCTAssert(app.staticTexts["Fixture Detail Date"].exists)
        XCTAssert(app.staticTexts["Fixture Detail Time"].exists)
        XCTAssert(app.staticTexts["Fixture Detail Postcode"].exists)
        XCTAssert(app.staticTexts["Automated Tester 1"].exists)
        XCTAssert(app.staticTexts["Automated Tester 2"].exists)
    }
    
    func test04FixtureNineOppositionGoals() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.tables[AccessabilityIdentifier.FixturesTable.rawValue].staticTexts["Test Opposition 4"].tap()
        
        app.textFields["Detail Home Team Goals"].tap()
        XCTAssert(app.pickerWheels["0"].exists)
        app.pickerWheels["0"].swipeUp()
        app.toolbars["Toolbar"].buttons["Done"].tap()

        app.navigationBars["TBG2.FixtureInformationView"].buttons["Back"].tap()
        
        //Try and compare the 2 values that should match :(
    }
    
    func test05FixtureMotm() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.tables[AccessabilityIdentifier.FixturesTable.rawValue].staticTexts["Test Opposition 4"].tap()
        
        let tablesQuery = app.tables
        XCTAssertEqual(tablesQuery.cells.images["Motm"].exists, false)
        //ADD THE MOTM TO PLAYER 2
        tablesQuery.staticTexts["Automated Tester 2"].swipeLeft()
        tablesQuery.buttons["MOTM"].tap()
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.images["Motm"].exists, true)
        //REMOVE THE MOTM FROM PLAYER 2
        tablesQuery.staticTexts["Automated Tester 2"].swipeLeft()
        tablesQuery.buttons["Remove MOTM"].tap()
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.images["Motm"].exists, false)
        //ADD THE MOTM TO PLAYER 1
        tablesQuery.staticTexts["Automated Tester 1"].swipeLeft()
        tablesQuery.buttons["MOTM"].tap()
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.images["Motm"].exists, true)
    }
    
    func test06FixtureTeamGoals() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.tables[AccessabilityIdentifier.FixturesTable.rawValue].staticTexts["Test Opposition 4"].tap()
        
        let tablesQuery = app.tables
        XCTAssertEqual(tablesQuery.cells.images["GoalIcon"].exists, false)
        XCTAssertEqual(tablesQuery.cells.staticTexts["FixturePlayerGoalCount"].exists, false)
        //ADD 1 GOAL TO PLAYER 2 (1 Goal)
        tablesQuery.staticTexts["Automated Tester 2"].swipeLeft()
        tablesQuery.buttons["Add Goal"].tap()
        XCTAssertEqual(tablesQuery.cells.images["GoalIcon"].exists, true)
        XCTAssertEqual(tablesQuery.cells.staticTexts["FixturePlayerGoalCount"].exists, true)
        //REMOVE 1 GOAL FROM PLAYER 2 (0 Goals)
        tablesQuery.staticTexts["Automated Tester 2"].swipeLeft()
        tablesQuery.buttons["Minus Goal"].tap()
        XCTAssertEqual(tablesQuery.cells.images["GoalIcon"].exists, false)
        XCTAssertEqual(tablesQuery.cells.staticTexts["FixturePlayerGoalCount"].exists, false)
        //REMOVE 1 GOAL FROM PLAYER 2 (0 Goals)
        tablesQuery.staticTexts["Automated Tester 2"].swipeLeft()
        tablesQuery.buttons["Minus Goal"].tap()
        XCTAssertEqual(tablesQuery.cells.images["GoalIcon"].exists, false)
        XCTAssertEqual(tablesQuery.cells.staticTexts["FixturePlayerGoalCount"].exists, false)
        //Check this still is equal to 0?
        
        //ADD 1 GOAL TO PLAYER 1 (1 Goal)
        tablesQuery.staticTexts["Automated Tester 1"].swipeLeft()
        tablesQuery.buttons["Add Goal"].tap()
        XCTAssertEqual(tablesQuery.cells.images["GoalIcon"].exists, true)
        XCTAssertEqual(tablesQuery.cells.staticTexts["FixturePlayerGoalCount"].exists, true)
        //ADD 1 GOAL TO PLAYER 1 (2 Goals)
        tablesQuery.staticTexts["Automated Tester 1"].swipeLeft()
        tablesQuery.buttons["Add Goal"].tap()
        XCTAssertEqual(tablesQuery.cells.images["GoalIcon"].exists, true)
        XCTAssertEqual(tablesQuery.cells.staticTexts["FixturePlayerGoalCount"].exists, true)
        //Check the numbers says 2
    }
    
    func test07DeleteFixture() {
        XCUIApplication().tabBars.children(matching: .button).element(boundBy: 1).tap()
        XCUIApplication().tables.cells.containing(.staticText, identifier:"Test Opposition 4").element.swipeLeft()
        XCUIApplication().tables.buttons["Delete"].tap()
    }


}
