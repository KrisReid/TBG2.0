//
//  TBGUITeamTests.swift
//  TBG2UITests
//
//  Created by Kris Reid on 14/06/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import XCTest

class TBGUITeamTests: XCTestCase {

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

    func test01TableExists() {
        
        let app = XCUIApplication()
        
        XCTAssertTrue(app.tables.staticTexts["Goalkeepers"].exists)
        XCTAssertTrue(app.tables.staticTexts["Defenders"].exists)
        XCTAssertTrue(app.tables.staticTexts["Midfielders"].exists)
        XCTAssertTrue(app.tables.staticTexts["Strikers"].exists)
    }
    
    func test02playerDetail() {
        
        // add a plaveholder in if there are no entries ....
        
        let app = XCUIApplication()
        app.tables.staticTexts["Automated Tester 2"].tap()
        
        XCTAssertTrue(app.images[AccessabilityIdentifier.PlayerDetailProfilePicture.rawValue].exists)
        XCTAssertTrue(app.staticTexts[AccessabilityIdentifier.PlayerDetailPlayerName.rawValue].exists)
        XCTAssertTrue(app.staticTexts[AccessabilityIdentifier.PlayerDetailDateOfBirth.rawValue].exists)
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertTrue(elementsQuery.staticTexts["All Seasons"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Games Played"].exists)
//        XCTAssertTrue(elementsQuery.staticTexts["0"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["MOTM"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Goals Scored"].exists)

//        scrollViewsQuery.otherElements.containing(.staticText, identifier:"All Seasons").children(matching: .other).element.children(matching: .other).element(boundBy: 2).swipeLeft()
//        XCTAssertTrue(elementsQuery.staticTexts["2018 / 2019"].exists)
        
    }
    
    func test03ShareTeamExists() {
        let app = XCUIApplication()
        app.navigationBars["TBG2.TeamView"].buttons["plus icon"].tap()
        
        XCTAssertTrue(app.staticTexts[AccessabilityIdentifier.ShareTeamName.rawValue].exists)
        XCTAssertTrue(app.staticTexts[AccessabilityIdentifier.ShareTeamPostcode.rawValue].exists)
        XCTAssertTrue(app.tables.cells.staticTexts["-M9oHEGA47y9ZsDrpp59"].exists)
        
        //Artificial Swipe down
        let c = app.staticTexts[AccessabilityIdentifier.ShareTeamName.rawValue]
        let start = c.coordinate(withNormalizedOffset:  CGVector(dx: 0.0, dy: 0.0))
        let finish = c.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 100.0))
        start.press(forDuration: 0, thenDragTo: finish)
        
    }
    
    func test04ChangingTeamPINEnabledAndDisabled() {
        let app = XCUIApplication()
        app.navigationBars["TBG2.TeamView"].buttons["plus icon"].tap()
    
        app.tables.cells.staticTexts[AccessabilityIdentifier.ShareTeamPIN.rawValue].tap()
        app.textFields[AccessabilityIdentifier.TeamPINTeamPIN.rawValue].tap()
        app.textFields[AccessabilityIdentifier.TeamPINTeamPIN.rawValue].buttons["Clear text"].tap()
        
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["6"].tap()
        XCTAssertTrue(app.buttons["Done"].isEnabled)
        
        app.keys["7"].tap()
        XCTAssertFalse(app.buttons["Done"].isEnabled)
        
        app.keys["Delete"].tap()
        app.staticTexts["Done"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching:.any, identifier: "ShareTeamPIN").label, "123456")
        
        //Artificial Swipe down
        let c = app.staticTexts[AccessabilityIdentifier.ShareTeamName.rawValue]
        let start = c.coordinate(withNormalizedOffset:  CGVector(dx: 0.0, dy: 0.0))
        let finish = c.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 100.0))
        start.press(forDuration: 0, thenDragTo: finish)
        
    }
    
}
