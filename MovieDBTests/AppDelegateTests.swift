//
//  AppDelegateTests.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import XCTest
import UIKit
@testable import MovieDB

class AppDelegateTests: XCTestCase {

    var appDelegate = AppDelegate()
    var window: UIWindow? = UIWindow()
    
    override func setUp() {
        super.setUp()
        appDelegate.window = window
    }

    override func tearDown() {
        super.tearDown()
        window = nil
    }

    func testThatHasInitializerAfterInit() {
        XCTAssertNotNil(appDelegate.appInitializer, "should have a appInitializer after being initialized")
    }
    
    func testWindowIsKeyAfterApplicationLaunch() {
        let mainAppDelegate = UIApplication.shared.delegate
        if let mainAppDelegate = mainAppDelegate {
            if let window = mainAppDelegate.window {
                if let window = window {
                    XCTAssertTrue(window.isKeyWindow)
                }
                else {
                    XCTFail("app delegate window should not be nil")
                }
            } else {
                XCTFail("app delegate window should not be nil")
            }
        }
        else {
            XCTFail("shared application should have a delegate")
        }
    }
    
    func testThatDidFinishLaunchingWithOptionsReturnsTrue() {
        XCTAssertTrue(appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil),
                      "should return true from didFinishLaunchingWithOptions")
    }
    
}
