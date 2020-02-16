//
//  EntryPointEntryPointInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol EntryPointInteractorOutput: class, InteractorOutput {
    
    /// Service configuration.
    ///
    /// The function will be called by the interactor when the data is received
    /// - parameter configuration: system configuration data structure
    func onFetchedConfiguration(_ configuration: DTOConfiguration)
    
    /// List of available genres
    ///
    /// The function will be called by the interactor when the data is received
    /// - parameter genres: list of available genres
    func onFetchedGenres(_ genres: [DTOGenre])
    
    /// Informing about the current progress of data loading
    ///
    ///
    /// The function will be called by the interactor when the data is received
    /// - parameter progress: the value of progress. Values from 0.0 to 1.0 are used
    func onChangeProgress(_ progress: Float)
    
}

// Optional functions
extension EntryPointInteractorOutput {
    func onFetchedConfiguration(_ configuration: DTOConfiguration) {}
    func onFetchedGenres(_ genres: [DTOGenre]) {}
}
