//
//  marvelUITests.swift
//  marvelUITests
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import XCTest

class marvelUITests: XCTestCase {

    fileprivate let app = XCUIApplication()
    fileprivate let notExistsPredicate = NSPredicate(format: "exists != 1")
    fileprivate let existsPredicate = NSPredicate(format: "exists == 1")
    fileprivate let kTimeOut = 30.0
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {}

    func testNavigation() {
        detectedHUD()
        app.tables.matching(.table, identifier: "listTableView").cells.element(boundBy: 0).tap()
        detectedHUD()
        
        let buttonComics = app.otherElements.matching(identifier: "comics").buttons.element(matching: .button, identifier: "arrowButton")
        buttonComics.tap()
        buttonComics.tap()
        
        let buttonSeries = app.otherElements.matching(identifier: "series").buttons.element(matching: .button, identifier: "arrowButton")
        buttonSeries.tap()
        buttonSeries.tap()
        
        let buttonStories = app.otherElements.matching(identifier: "stories").buttons.element(matching: .button, identifier: "arrowButton")
        buttonStories.tap()
        buttonStories.tap()
        
        let buttonEvents = app.otherElements.matching(identifier: "events").buttons.element(matching: .button, identifier: "arrowButton")
        buttonEvents.tap()
        buttonEvents.tap()
        
        app.otherElements.matching(identifier: "urls").buttons.element(matching: .button, identifier: "arrowButton").tap()
        app.cells.element(matching: .cell, identifier: "url1").tap()
        
        expectation(for: existsPredicate, evaluatedWith: app.otherElements.webViews.element(matching: .webView, identifier: "webV"), handler: nil)
        waitForExpectations(timeout: kTimeOut, handler: nil)
        app.otherElements.buttons.element(matching: .button, identifier: "backArrow").tap()
        app.otherElements.matching(identifier: "urls").buttons.element(matching: .button, identifier: "arrowButton").tap()
        app.otherElements.buttons.element(matching: .button, identifier: "backArrow").tap()
    }
}

//MARK: - private methods -
private extension marvelUITests {
    func detectedHUD() {
        expectation(for: notExistsPredicate, evaluatedWith: app.otherElements["HUD"], handler: nil)
        waitForExpectations(timeout: kTimeOut, handler: nil)
    }
}
