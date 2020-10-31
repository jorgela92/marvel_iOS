//
//  marvelTests.swift
//  marvelTests
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import XCTest
@testable import marvel

class marvelTests: XCTestCase {

    fileprivate let kTimeOut = 20.0
    
    override func setUp() {}

    override func tearDown() {}

    func testCharactersList() {
        let expectation = XCTestExpectation(description: "CharctersList")
        CharactersServiceHandler().getCharacters() { (response) in
            switch response {
                case .success(_):
                    expectation.fulfill()
                    break
                case .error(let error):
                    XCTFail("CharctersList failed: " + error.message)
                    break
            }
        }
        wait(for: [expectation], timeout: kTimeOut)
    }

    func testCharacterDetail() {
        let expectation = XCTestExpectation(description: "CharcterDetail")
        CharactersServiceHandler().getDetailCharacter(characterId: 1011334) { (response) in
            switch response {
                case .success(_):
                    expectation.fulfill()
                    break
                case .error(let error):
                    XCTFail("CharcterDetail failed: " + error.message)
                    break
            }
        }
        wait(for: [expectation], timeout: kTimeOut)
    }
}
