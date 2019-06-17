//
//  MockLanguagePresenter.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
@testable import MovieDB

class MockLanguagePresenter: LanguageViewOutput {
    
    var selectLanguageCalled = false
    var searchCalled = false
    var viewIsReadyCalled = false
    
    func selectLanguage(_ language: DTOLanguage) {
        selectLanguageCalled = true
    }
    
    func search(_ query: String) {
        searchCalled = true
    }
    
    func viewIsReady() {
        viewIsReadyCalled = true
    }
    
}
