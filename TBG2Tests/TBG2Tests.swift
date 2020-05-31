//
//  TBG2Tests.swift
//  TBG2Tests
//
//  Created by Kris Reid on 26/04/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import XCTest
@testable import TBG2

class TBG2Tests: XCTestCase {

//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
    
    
//    class func ImageUrlConverter (url: URL) -> UIImageView {
//        let image = UIImageView()
//        image.sd_cancelCurrentImageLoad()
//        image.sd_setImage(with: url, completed: nil)
//        return image
//    }
    
    func testImageUrlConverter() {
        // Given
        let sampleUrl = URL(fileURLWithPath: "https://firebasestorage.googleapis.com/v0/b/tbg2-5a636.appspot.com/o/crest_images%2FCE57B779-AF07-4576-B6B7-B3ECDBF50081.jpeg?alt=media&token=2d2db8af-2ee0-4c42-aa59-0f71ce672a51")
        // When
        let updatedPostcode = Helper.ImageUrlConverter(url: sampleUrl)
        // Then
        XCTAssertNotNil(updatedPostcode)
    }
    
    func testRemoveSpaces() {
        // Given
        let samplePostcode = "  AL8 7SN   "
        // When
        let updatedPostcode = Helper.removeSpaces(text: samplePostcode)
        // Then
        XCTAssertEqual(updatedPostcode, "AL87SN")
    }
    
    func testStringToDate() {
        // Given
        let date = "20 May 2020"
        // When
        let newDate = Helper.stringToDate(date: date)
        // Then
        let testDate = Date()
        XCTAssertNotEqual(newDate, testDate)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
