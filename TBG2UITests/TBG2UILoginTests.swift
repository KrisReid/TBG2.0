//
//  TBG2UITests.swift
//  TBG2UITests
//
//  Created by Kris Reid on 31/05/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import XCTest

class TBG2UILoginTests: XCTestCase {

    override func setUpWithError() throws {
        XCUIApplication().launch()
        continueAfterFailure = false
    }

    
    func test01LoginComponentsExist() {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.textFields[AccessabilityIdentifier.LoginEmail.rawValue].exists)
        XCTAssertTrue(app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue].exists)
        XCTAssertTrue(app.buttons[AccessabilityIdentifier.LoginSignupButton.rawValue].exists)
        XCTAssertTrue(app.buttons[AccessabilityIdentifier.LoginButton.rawValue].exists)
    }
    
    func test02IncorrectPassword() {
        let app = XCUIApplication()
        
        app.textFields[AccessabilityIdentifier.LoginEmail.rawValue].tap()
        app.textFields[AccessabilityIdentifier.LoginEmail.rawValue].typeText("automated_tester_1@tbg.com")
        app.buttons[AccessabilityIdentifier.LoginButton.rawValue].tap()
        
        addUIInterruptionMonitor(withDescription: "Incorrect Password", handler: { alert in
          alert.buttons["OK"].tap()
          return true
        })
        app.tap()
    }
    
    func test03InvalidEmail() {
        let app = XCUIApplication()
        
        app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue].tap()
        app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue].typeText("123456")
        app.buttons[AccessabilityIdentifier.LoginButton.rawValue].tap()
    
        let alertDialog = app.alerts["Invalid Email"]
        alertDialog.buttons["OK"].tap()
    }
    
    func test04LoginError() {
        let app = XCUIApplication()
        
        app.textFields[AccessabilityIdentifier.LoginEmail.rawValue].tap()
        app.textFields[AccessabilityIdentifier.LoginEmail.rawValue].typeText("automated@tbg.com")
        
        app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue].tap()
        app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue].typeText("123456")
        
        app.buttons[AccessabilityIdentifier.LoginButton.rawValue].tap()
        
        //Fails in Bitrise - Why?
        let alertDialog = app.alerts["Login Error"]
        alertDialog.buttons["OK"].tap()
    }
    
}
