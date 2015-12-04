//
//  HomeInventoryUITests.swift
//  HomeInventoryUITests
//
//  Created by Jason Shultz on 12/2/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import XCTest
import RealmSwift

class HomeInventoryUITests: XCTestCase {

        
    override func setUp() {
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name

        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let app = XCUIApplication()
        setLanguage(app)
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        snapshot("0Launch")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSayHello() {
//        let app = XCUIApplication()
//        app.menuButtons.buttons.
//        app.navigationBars.
    }
    
}
