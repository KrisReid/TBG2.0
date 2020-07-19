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
        
        let app = XCUIApplication()
        app.launch()

        let emailAddressTextField = app.textFields[AccessabilityIdentifier.LoginEmail.rawValue]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("automated_tester_1@tbg.com")
        
        let passwordSecureTextField = app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123456789")
        
        app.buttons[AccessabilityIdentifier.LoginButton.rawValue].tap()

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
    
    func testCreatingFixtureThree() {
        let app = XCUIApplication()
            XCUIApplication().tabBars.children(matching: .button).element(boundBy: 1).tap()

            //Check the Fixture table and add fixture exists
            XCTAssertTrue(app.tables[AccessabilityIdentifier.FixturesTable.rawValue].exists)
            XCTAssertTrue(app.navigationBars["TBG2.FixturesView"].buttons["plus icon"].exists)
        
            //Create a fixture to play with
            app.navigationBars["TBG2.FixturesView"].buttons["plus icon"].tap()
            app.buttons["Away"].tap()
            app.textFields[AccessabilityIdentifier.CreateFixtureOpposition.rawValue].tap()
            app.textFields[AccessabilityIdentifier.CreateFixtureOpposition.rawValue].typeText("Test Opposition 3")
            app.textFields[AccessabilityIdentifier.CreateFixtureDate.rawValue].tap()
            app.textFields[AccessabilityIdentifier.CreateFixtureDate.rawValue].typeText("29 May 2020")
            app.textFields[AccessabilityIdentifier.CreateFixtureTime.rawValue].tap()
            app.textFields[AccessabilityIdentifier.CreateFixtureTime.rawValue].typeText("3:30 PM")
            app.textFields[AccessabilityIdentifier.CreateFixturePostcode.rawValue].tap()
            app.textFields[AccessabilityIdentifier.CreateFixturePostcode.rawValue].typeText("BS11 0BT")
            app.buttons[AccessabilityIdentifier.CreateFixtureCreateGame.rawValue].tap()
            
            //Check the fields in the fixture detail exist
            app.tables[AccessabilityIdentifier.FixturesTable.rawValue].staticTexts["Test Opposition 3"].tap()
            XCTAssert(app.images["Home Team Crest"].exists)
            XCTAssert(app.images["Away Team Crest"].exists)
            XCTAssert(app.textFields["Detail Home Team Goals"].exists)
            XCTAssert(app.textFields["Detail Away Team Goals"].exists)
            XCTAssert(app.staticTexts["Fixture Detail Date"].exists)
            XCTAssert(app.staticTexts["Fixture Detail Time"].exists)
            XCTAssert(app.staticTexts["Fixture Detail Postcode"].exists)
            XCTAssert(app.staticTexts["Automated Tester 1"].exists)
            XCTAssert(app.staticTexts["Automated Tester 2"].exists)
        
            //Award 9 goals to the home team
            app.textFields["Detail Home Team Goals"].tap()
            XCTAssert(app.pickerWheels["0"].exists)
            app.pickerWheels["0"].swipeUp()
            app.toolbars["Toolbar"].buttons["Done"].tap()

            //Award a MOTM
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
            
            //Award and Remove goals for your team
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
            
            //Back out and delete the fixture
            app.navigationBars["TBG2.FixtureInformationView"].buttons["Back"].tap()
            XCUIApplication().tables.cells.containing(.staticText, identifier:"Test Opposition 4").element.swipeLeft()
            XCUIApplication().tables.buttons["Delete"].tap()
    }

}
