//
//  MockLanguageInteractor.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
@testable import MovieDB

class MockLanguageInteractor: LanguageInteractorInput {
    
    var fetchLanguagesCalled = false
    
    func fetchLanguages() {
        fetchLanguagesCalled = true
    }
    
}
