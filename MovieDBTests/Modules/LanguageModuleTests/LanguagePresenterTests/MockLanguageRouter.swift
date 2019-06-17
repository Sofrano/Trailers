//
//  MockLanguageRouterView.swift
//  MovieDBTests
//
//  Created by Dmitriy Safarov on 17/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import LightRoute
@testable import MovieDB

class MockLanguageRouter: LanguageRouterInput {
    var transitionHandler: TransitionHandler!
    var showWelcomeMessageCalled = false
    var openEntryPointCalled = false
    
    func openEntryPoint() {
        openEntryPointCalled = true
    }
    
    func showWelcomeMessage() {
        showWelcomeMessageCalled = true
    }
    
}
