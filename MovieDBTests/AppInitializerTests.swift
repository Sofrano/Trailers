//
//  AppInitializerTests.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import XCTest
import UIKit
@testable import MovieDB

class AppInitializerTests: XCTestCase {

    var appInitializer: AppInitializer = AppInitializer()
    
    lazy var currentLanguage: String? = {
        return RSettings.language
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        RSettings.language = currentLanguage
    }

    func testThatUserStartsApplicationAndNoLanguageIsSelected() {
        RSettings.language = nil
        let window = UIWindow()
        let navController = UINavigationController()
        window.rootViewController = navController
        appInitializer.installRootViewControllerIntoWindow(window: window)
        if let rootVC = window.rootViewController {
            XCTAssertNotNil(rootVC as? LanguageViewController, "must be a LanguageViewController")
        } else {
            XCTFail("first view controller must be a view controller")
        }
    }
    
    func testThatUserStartsApplicationAndLanguageIsSelected() {
        RSettings.language = ELanguage.en.languageIdentifier
        
        let window = UIWindow()
        let navController = UINavigationController()
        window.rootViewController = navController
        appInitializer.installRootViewControllerIntoWindow(window: window)
        if let rootVC = window.rootViewController {
            XCTAssertNotNil(rootVC as? EntryPointViewController, "must be a EntryPointViewController")
        } else {
            XCTFail("first view controller must be a view controller")
        }
    }

}
