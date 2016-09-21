//
//  URLSessionInvalidationUITests.swift
//  URLSessionInvalidationUITests
//
//  Created by Gleb Arkhipov on 21/09/16.
//  Copyright © 2016 Gleb Arkhipov. All rights reserved.
//

import XCTest

class URLSessionInvalidationUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSessionIsInvalidatedAfterGoingToBackground() {
        
        let app = XCUIApplication()
        let device = XCUIDevice.shared()
        let progressBar = app.progressIndicators.element
        let statusLabel = app.staticTexts["statusLabel"]

        // Start downloading
        app.buttons["startButton"].tap()
        
        // Wait for the download to start
        expectation(for: NSPredicate(format: "value != '0%'"), evaluatedWith: progressBar, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        // Put the app to background
        device.press(.home)
        
        // Wait a bit. Doesn't "truly" get to background without it? :-|
        sleep(2)
        
        // Return the app to foreground. Can easily break soon
        XCUIApplication.fb_SpringBoard().fb_tap(withIdentifier: "URLSessionInvalidation")
        
        // Wait for the download to finish
        expectation(for: NSPredicate(format: "value = '100%'"), evaluatedWith: progressBar, handler: nil)
        waitForExpectations(timeout: 120, handler: nil)
        
        // Check if session was invalidated
        XCTAssertTrue(statusLabel.label.hasPrefix("Session invalidated"))
        
    }
    
}
