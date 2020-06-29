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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        XCUIApplication().launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test01LoginComponentsExist() {
        let app = XCUIApplication()
        XCTAssertTrue(app.textFields["Email Address"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
        XCTAssertTrue(app.staticTexts["Don't have an account? Sign up instead"].exists)
    }
    
    
    func test02IncorrectPassword() {
        let email = "automated_tester_1@tbg.com"
        
        let app = XCUIApplication()
        
        let emailAddressTextField = app.textFields["Email Address"]
        XCTAssertTrue(emailAddressTextField.exists)
        emailAddressTextField.tap()
        emailAddressTextField.typeText(email)
        app.buttons["Login"].tap()
        
        addUIInterruptionMonitor(withDescription: "Incorrect Password", handler: { alert in
          alert.buttons["OK"].tap()
          return true
        })
        app.tap()
    }
    
    func test03InvalidEmail() {
        
        let password = "123456"
        
        let app = XCUIApplication()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(password)
        
        app.buttons["Login"].tap()
        
        let alertDialog = app.alerts["Invalid Email"]
        XCTAssertTrue(alertDialog.exists)
        alertDialog.buttons["OK"].tap()
    }
    
    func test04LoginError() {
        let email = "automated@tbg.com"
        let password = "123456"
        
        let app = XCUIApplication()
        
        let emailAddressTextField = app.textFields["Email Address"]
        XCTAssertTrue(emailAddressTextField.exists)
        emailAddressTextField.tap()
        emailAddressTextField.typeText(email)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(password)
        
        app.buttons["Login"].tap()
        
        let alertDialog = app.alerts["Login Error"]
        XCTAssertTrue(alertDialog.exists)
        alertDialog.buttons["OK"].tap()
    }
    
    
    func test05SuccessfulLogin() {
        let email = "automated_tester_1@tbg.com"
        let password = "123456789"
        
        let app = XCUIApplication()
        
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
        
        //Sign out
        let button = tabBarsQuery.children(matching: .button).element(boundBy: 2)
        button.tap()
        app.tables.staticTexts["Sign Out"].tap()
    }
    
}
