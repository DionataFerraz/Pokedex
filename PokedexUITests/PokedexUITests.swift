//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Dionata Leonel Machado Ferraz on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import XCTest

class PokedexUITests: XCTestCase {
    var app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UITests"]
        app.launch()
    }

    func testExample() {
//        XCUIApplication().tables.staticTexts["Wartortle"].swipeUp()
        
//        let app = XCUIApplication()
//        let charizardStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Charizard"]/*[[".cells.staticTexts[\"Charizard\"]",".staticTexts[\"Charizard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        charizardStaticText.swipeUp()
//        charizardStaticText.tap()
//        app.buttons["ic path"].tap()
        
        let cells = app.descendants(matching: .cell)
        let firstCell = cells.firstMatch
        firstCell.tap()
        
        XCTAssertTrue(app.otherElements["detailView"].waitForExistence(timeout: 1))
        
    }

}
