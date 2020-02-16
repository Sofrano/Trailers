//
//  EntryPointEntryPointViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol EntryPointViewInput: class {

    /// Informing about the current progress of data loading
    /// - parameter progress: the value of progress. Values from 0.0 to 1.0 are used
    func updateProgress(_ progress: Float)
    /// Setup initial state configuration
    func setupInitialState()
    
}
