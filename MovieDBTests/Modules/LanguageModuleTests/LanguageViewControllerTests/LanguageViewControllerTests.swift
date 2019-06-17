//
//  LanguageViewControllerTests.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import XCTest
import UIKit
import Rswift

@testable import MovieDB

class LanguageViewControllerTests: XCTestCase {

    var languageViewController: LanguageViewController?
    var output: MockLanguagePresenter?
    
    override func setUp() {
        super.setUp()
        languageViewController = R.storyboard.languageView.languageViewController()
        output = MockLanguagePresenter()
        languageViewController?.output = output
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Base tests
    
    func testThatLangaugeViewControllerExists() {
        XCTAssertNotNil(languageViewController, "a LanguageViewController instance should be creatable from storyboard")
    }
    
    // MARK: viewDidLoad tests
    
    func testTableViewIsPresent() {
        _ = languageViewController?.view
        XCTAssertNotNil(languageViewController?.tableView, "a tableView instance should be present")
    }
    
    func testSearchBarIsPresent() {
        _ = languageViewController?.view
        XCTAssertNotNil(languageViewController?.searchBar, "a searchBar instance should be present")
    }
    
    func testSearchBarHaveDelegate() {
        _ = languageViewController?.view
        XCTAssertNotNil(languageViewController?.searchBar?.delegate, "searchBar should have a delegate")
    }
    
    func testPresenterViewIsReady() {
        _ = languageViewController?.view
        guard let output = output else {
            XCTFail("a LoginModule instance should be created")
            return
        }
        XCTAssertTrue(output.viewIsReadyCalled, "viewIsReady should be called")
    }
    
    func testPresenterSearchBar() {
        _ = languageViewController?.view
        guard let output = output else {
            XCTFail("a LoginModule instance should be created")
            return
        }
        languageViewController?.searchBar(languageViewController?.searchBar ?? UISearchBar(), textDidChange: "ABC")
        XCTAssertTrue(output.searchCalled, "search should be called")
    }
    
}
