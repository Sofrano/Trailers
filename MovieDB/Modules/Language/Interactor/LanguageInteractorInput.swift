//
//  EntryPointEntryPointInteractorInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol LanguageInteractorInput {

    var userLanguage: String? { get }
    var defaultLanguage: String { get }
    
    func fetchLanguages()
    func setLanguage(_ language: DTOLanguage)
    
    
}
