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
    
    func test01SignupPersonalDetailsExist() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an account? Sign up instead"]/*[[".buttons[\"Don't have an account? Sign up instead\"].staticTexts[\"Don't have an account? Sign up instead\"]",".staticTexts[\"Don't have an account? Sign up instead\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.scrollViews.otherElements.buttons["camera icon"].exists)
        XCTAssertTrue(app.scrollViews.otherElements.textFields["Full Name"].exists)
        XCTAssertTrue(app.textFields["Email Address"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.scrollViews.otherElements.textFields["Date of birth"].exists)
        XCTAssertTrue(app.textFields["House Number"].exists)
        XCTAssertTrue(app.textFields["Postcode"].exists)
        XCTAssertTrue(app.buttons["Create Team"].exists)
        XCTAssertTrue(app.buttons["Join Team"].exists)
    }
    
    
    
//    func testCameraImage() {
//
//        let app = XCUIApplication()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an account? Sign up instead"]/*[[".buttons[\"Don't have an account? Sign up instead\"].staticTexts[\"Don't have an account? Sign up instead\"]",".staticTexts[\"Don't have an account? Sign up instead\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.scrollViews.otherElements.buttons["camera icon"].tap()
//
//    }
    


}
