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
    
    func testFixtureTableExists() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.children(matching: .button).element(boundBy: 1).tap()
    
        XCTAssertTrue(app.tables[AccessabilityIdentifier.FixturesTable.rawValue].exists)
        XCTAssertTrue(app.navigationBars["TBG2.FixturesView"].buttons["plus icon"].exists)
        
//        //Code for deleting a fixture
//        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Test Opposition 2").element/*[[".cells.containing(.button, identifier:\"Delete\").element",".cells.containing(.button, identifier:\"trailing0\").element",".cells.containing(.staticText, identifier:\"15 Oct 2031 (14:30)\").element",".cells.containing(.staticText, identifier:\"Test Opposition 2\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
    }
    
    func testCreateHistoricFixture() {
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
    
    
    
    // test feture detail exists
    // test opposition goals
    // test player motm
    // test goal additon and subtraction
    
    func testFixtureDetailExists() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.tables[AccessabilityIdentifier.FixturesTable.rawValue].staticTexts["Test Opposition 4"].tap()
        
//        XCTAssertTrue(app.staticTexts["12 Mar 1992"].exists)
        
    }
    
    
    func testHistoricFeatureDetail() {
        
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.tables[AccessabilityIdentifier.FixturesTable.rawValue].staticTexts["Test Opposition 4"].tap()
        
        
        
        
        
        
//        let element3 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//        let element = element3.children(matching: .other).element(boundBy: 0)
//        element.children(matching: .other).element(boundBy: 0).tap()
//
//        let element2 = element.children(matching: .other).element(boundBy: 1)
//        element2.children(matching: .textField).element(boundBy: 0).tap()
//        app/*@START_MENU_TOKEN@*/.pickerWheels["0"]/*[[".pickers.pickerWheels[\"0\"]",".pickerWheels[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
//        app.toolbars["Toolbar"].buttons["Done"].tap()
//        element2.children(matching: .textField).element(boundBy: 1).tap()
//        element.children(matching: .other).element(boundBy: 2).tap()
//        app.staticTexts["29 May 2020"].tap()
//        app.staticTexts["3:30 PM"].tap()
//        element3.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2).children(matching: .button).element.tap()
//        app.statusBars/*@START_MENU_TOKEN@*/.buttons["breadcrumb"]/*[[".buttons[\"Return to TBG\"]",".buttons[\"breadcrumb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Automated Tester 1"]/*[[".cells.staticTexts[\"Automated Tester 1\"]",".staticTexts[\"Automated Tester 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let tablesQuery = XCUIApplication().tables
//        let automatedTester2StaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Automated Tester 2"]/*[[".cells.staticTexts[\"Automated Tester 2\"]",".staticTexts[\"Automated Tester 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        automatedTester2StaticText.swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["trailing0"]/*[[".cells",".buttons[\"MOTM\"]",".buttons[\"trailing0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        automatedTester2StaticText.swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["trailing0"]/*[[".cells",".buttons[\"Remove MOTM\"]",".buttons[\"trailing0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        automatedTester2StaticText.swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["trailing1"]/*[[".cells",".buttons[\"Add Goal\"]",".buttons[\"trailing1\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let tablesQuery = XCUIApplication().tables
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Automated Tester 1"]/*[[".cells.staticTexts[\"Automated Tester 1\"]",".staticTexts[\"Automated Tester 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["trailing1"]/*[[".cells",".buttons[\"Add Goal\"]",".buttons[\"trailing1\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//
//        let tablesQuery = app.tables
//        let trailing2Button = tablesQuery/*@START_MENU_TOKEN@*/.buttons["trailing2"]/*[[".cells",".buttons[\"Minus Goal\"]",".buttons[\"trailing2\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        trailing2Button.tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Automated Tester 1"]/*[[".cells.staticTexts[\"Automated Tester 1\"]",".staticTexts[\"Automated Tester 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
//        trailing2Button.tap()
//
//        let app2 = app
//        let app = app2
//        let backButton = app.navigationBars["TBG2.FixtureInformationView"].buttons["Back"]
//        backButton.tap()
//
//        let fixturesTableTable = app2.tables["Fixtures Table"]
//        fixturesTableTable/*@START_MENU_TOKEN@*/.staticTexts["2"]/*[[".cells.staticTexts[\"2\"]",".staticTexts[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        backButton.tap()
//        fixturesTableTable/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        backButton.tap()
//
//        let app = XCUIApplication()
//        let backButton = app.navigationBars["TBG2.FixtureInformationView"].buttons["Back"]
//        backButton.tap()
//
//        let fixturesTableTable = app.tables["Fixtures Table"]
//        fixturesTableTable/*@START_MENU_TOKEN@*/.staticTexts["Test Opposition 4"]/*[[".cells.staticTexts[\"Test Opposition 4\"]",".staticTexts[\"Test Opposition 4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        backButton.tap()
//
//        let staticText = fixturesTableTable/*@START_MENU_TOKEN@*/.staticTexts["29 May 2020 (3:30 PM)"]/*[[".cells.staticTexts[\"29 May 2020 (3:30 PM)\"]",".staticTexts[\"29 May 2020 (3:30 PM)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        staticText.tap()
//        backButton.tap()
//        staticText.tap()
//        backButton.tap()
                
        
    }

}
