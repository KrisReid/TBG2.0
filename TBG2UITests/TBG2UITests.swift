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

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testLaunchPerformance() throws {
//        if #available(iOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    func testIncorrectPassword() {
        let email = "test@tbg.com"
        
        let app = XCUIApplication()
        app.launch()
        
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
        testLoginError()
    }
    
    func testLoginError() {
        
        let password = "123456"
        
        let app = XCUIApplication()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(password)
        
        app.buttons["Login"].tap()
        
        let alertDialog = app.alerts["Login Error"]
        XCTAssertTrue(alertDialog.exists)
        alertDialog.buttons["OK"].tap()
        
//        addUIInterruptionMonitor(withDescription: "Login Error", handler: { alert in
//          alert.buttons["OK"].tap()
//          return true
//        })
//        app.tap()
    }
    
    func testSuccessfulLogin() {
        let email = "automated_tester@tbg.com"
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
    
    func testLogout() {
        
        let app = XCUIApplication()
        app.launch()
        
        let tabBarsQuery = XCUIApplication().tabBars
        let button = tabBarsQuery.children(matching: .button).element(boundBy: 2)
        button.tap()
        app.tables.staticTexts["Sign Out"].tap()
                
    }
    
    
}
