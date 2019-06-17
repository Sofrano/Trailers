//
//  EntryPointEntryPointRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol LanguageRouterInput: AlertRoutable, LoadingRoutable, PresentRoutable {

    func openEntryPoint() 
    func showWelcomeMessage()
    
}
