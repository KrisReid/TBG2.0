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
        XCTAssertTrue(emailAddressTextField.exists)
        emailAddressTextField.tap()
        emailAddressTextField.typeText(email)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(password)
        
        app.buttons["Login"].tap()
        
        let tabBarsQuery = app.tabBars
        let teamTab = tabBarsQuery.children(matching: .button).element(boundBy: 0)
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: teamTab, handler: nil)
        waitForExpectations(timeout: 4, handler: nil)
    }

    override func tearDownWithError() throws {
        let app = XCUIApplication()
        let tabBarsQuery = XCUIApplication().tabBars
        let button = tabBarsQuery.children(matching: .button).element(boundBy: 2)
        button.tap()
        app.tables.staticTexts["Sign Out"].tap()
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
