//
//  DatabaseTests.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieDB

class DatabaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testChangeLanguage() {
        let currentLanguage = RSettings.language
        RSettings.language = ELanguage.en.languageIdentifier
        XCTAssert(RSettings.language == ELanguage.en.languageIdentifier)
        RSettings.language = nil
        XCTAssert(RSettings.language == nil)
        RSettings.language = currentLanguage
    }
    
    
    
}
