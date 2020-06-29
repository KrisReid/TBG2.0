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

    func test01TableExists() {
        
        let app = XCUIApplication()
        let emptyListTablesQuery = app.tables["Empty list, Goalkeepers, Defenders, Midfielders, Strikers, Empty list"].tables.matching(identifier: "Empty list")
        
        XCTAssertTrue(emptyListTablesQuery.staticTexts["Goalkeepers"].exists)
        XCTAssertTrue(emptyListTablesQuery.staticTexts["Defenders"].exists)
        XCTAssertTrue(emptyListTablesQuery.staticTexts["Midfielders"].exists)
        XCTAssertTrue(emptyListTablesQuery.staticTexts["Strikers"].exists)
    }
    
    func test02playerDetail() {
        let app = XCUIApplication()
        
        app.tables["Empty list, Goalkeepers, Defenders, Midfielders, Strikers, Empty list"].tables.matching(identifier: "Empty list").staticTexts["Automated Tester 2"].tap()
        
        XCTAssertTrue(app.staticTexts["Automated Tester 2"].exists)
        XCTAssertTrue(app.staticTexts["12 Mar 1992"].exists)
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertTrue(elementsQuery.staticTexts["All Seasons"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Games Played"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["77"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["MOTM"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Goals Scored"].exists)

        scrollViewsQuery.otherElements.containing(.staticText, identifier:"All Seasons").children(matching: .other).element.children(matching: .other).element(boundBy: 2).swipeLeft()
        XCTAssertTrue(elementsQuery.staticTexts["2018 / 2019"].exists)
        
    }
    
    func test03ShareTeamExists() {
        let app = XCUIApplication()
        app.navigationBars["TBG2.TeamView"].buttons["plus icon"].tap()
        
        XCTAssertTrue(app.staticTexts[AccessabilityIdentifier.TeamName.rawValue].exists)
        XCTAssertTrue(app.staticTexts[AccessabilityIdentifier.TeamPostcode.rawValue].exists)
        XCTAssertTrue(app.tables.cells.staticTexts["-M9oHEGA47y9ZsDrpp59"].exists)
        
        //Artificial Swipe down
        let c = app.staticTexts[AccessabilityIdentifier.TeamName.rawValue]
        let start = c.coordinate(withNormalizedOffset:  CGVector(dx: 0.0, dy: 0.0))
        let finish = c.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 100.0))
        start.press(forDuration: 0, thenDragTo: finish)
        
    }
    
    func test04ChangingTeamPINEnabledAndDisabled() {
        let app = XCUIApplication()
        app.navigationBars["TBG2.TeamView"].buttons["plus icon"].tap()
    
        app.tables.cells.staticTexts[AccessabilityIdentifier.ShareTeamPIN.rawValue].tap()
        app.textFields[AccessabilityIdentifier.TeamPIN.rawValue].tap()
        app.textFields[AccessabilityIdentifier.TeamPIN.rawValue].buttons["Clear text"].tap()
        
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
        
        XCTAssertEqual(app.staticTexts.element(matching:.any, identifier: "Share Team PIN").label, "123456")
        
        //Artificial Swipe down
        let c = app.staticTexts[AccessabilityIdentifier.TeamName.rawValue]
        let start = c.coordinate(withNormalizedOffset:  CGVector(dx: 0.0, dy: 0.0))
        let finish = c.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 100.0))
        start.press(forDuration: 0, thenDragTo: finish)
        
    }
    
    
    
}
