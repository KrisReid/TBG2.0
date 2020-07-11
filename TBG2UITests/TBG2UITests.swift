//
//  TBG2UITests.swift
//  TBG2UITests
//
//  Created by Kris Reid on 31/05/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import XCTest

class TBG2UITests: XCTestCase {

    override func setUpWithError() throws {
        XCUIApplication().launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test01LoginComponentsExist() {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.textFields[AccessabilityIdentifier.LoginEmail.rawValue].exists)
        XCTAssertTrue(app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue].exists)
        XCTAssertTrue(app.buttons[AccessabilityIdentifier.LogininSignupButton.rawValue].exists)
        XCTAssertTrue(app.buttons[AccessabilityIdentifier.LoginButton.rawValue].exists)
    }
    
    func test02IncorrectPassword() {
        let app = XCUIApplication()
        
        let emailAddressTextField = app.textFields[AccessabilityIdentifier.LoginEmail.rawValue]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("automated_tester_1@tbg.com")
        app.buttons[AccessabilityIdentifier.LoginButton.rawValue].tap()
        
        addUIInterruptionMonitor(withDescription: "Incorrect Password", handler: { alert in
          alert.buttons["OK"].tap()
          return true
        })
        app.tap()
    }
    
    func test03InvalidEmail() {
        let app = XCUIApplication()
        
        let passwordSecureTextField = app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123456")
        app.buttons[AccessabilityIdentifier.LoginButton.rawValue].tap()
        
        let alertDialog = app.alerts["Invalid Email"]
        XCTAssertTrue(alertDialog.exists)
        alertDialog.buttons["OK"].tap()
    }
    
    func test04LoginError() {
        let app = XCUIApplication()
        
        let emailAddressTextField = app.textFields[AccessabilityIdentifier.LoginEmail.rawValue]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("automated@tbg.com")
        
        let passwordSecureTextField = app.secureTextFields[AccessabilityIdentifier.LoginPassword.rawValue]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123456")
        
        app.buttons[AccessabilityIdentifier.LoginButton.rawValue].tap()
        
        let alertDialog = app.alerts["Login Error"]
        XCTAssertTrue(alertDialog.exists)
        alertDialog.buttons["OK"].tap()
    }
    
    
    func test05SuccessfulLogin() {
        let app = XCUIApplication()
        
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
        waitForExpectations(timeout: 4, handler: nil)
        
        //Sign out
        let button = tabBarsQuery.children(matching: .button).element(boundBy: 2)
        button.tap()
        app.tables.staticTexts["Sign Out"].tap()
    }
    
}
