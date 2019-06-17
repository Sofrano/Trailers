//
//  MockLanguageView.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
@testable import MovieDB

class MockLanguageView: LanguageViewInput {
    var scrollToIndex: Int?
    var updateCalled = false
    var setupInitialStateCalled = false
    var viewModel: LanguageListViewModel?
    
    func scrollToIndex(_ index: Int) {
        scrollToIndex = index
    }
    
    func update(with languageListViewModel: LanguageListViewModel) {
        updateCalled = true
        viewModel = languageListViewModel
    }
    
    func setupInitialState() {
        setupInitialStateCalled = true
    }
    
    
}
