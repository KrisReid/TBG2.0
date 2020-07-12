//
//  TBGUISignupTests.swift
//  TBG2UITests
//
//  Created by Kris Reid on 14/06/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import XCTest

class TBGUISignupTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
       
    }
    
    func test01SignupToTeam() {
        let app = XCUIApplication()
        
        app.buttons[AccessabilityIdentifier.LogininSignupButton.rawValue].tap()

        XCTAssertTrue(app.scrollViews.otherElements.buttons[AccessabilityIdentifier.SignupProfileButton.rawValue].exists)
        XCTAssertTrue(app.textFields[AccessabilityIdentifier.SignupFullName.rawValue].exists)
        XCTAssertTrue(app.textFields[AccessabilityIdentifier.SignupEmailAddress.rawValue].exists)
        XCTAssertTrue(app.secureTextFields[AccessabilityIdentifier.SignupPassword.rawValue].exists)
        XCTAssertTrue(app.textFields[AccessabilityIdentifier.SignupDOB.rawValue].exists)
        XCTAssertTrue(app.textFields[AccessabilityIdentifier.SignupHouseNumber.rawValue].exists)
        XCTAssertTrue(app.textFields[AccessabilityIdentifier.SignupPostcode.rawValue].exists)
        XCTAssertTrue(app.buttons[AccessabilityIdentifier.SignupCreateTeamButton.rawValue].exists)
        XCTAssertTrue(app.buttons[AccessabilityIdentifier.SignupJoinTeamButton.rawValue].exists)
    }
    
    
//    func testCameraImage() {
//
//        let app = XCUIApplication()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an account? Sign up instead"]/*[[".buttons[\"Don't have an account? Sign up instead\"].staticTexts[\"Don't have an account? Sign up instead\"]",".staticTexts[\"Don't have an account? Sign up instead\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.scrollViews.otherElements.buttons["camera icon"].tap()
//
//    }
    


}
