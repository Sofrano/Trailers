//
//  EntryPointEntryPointViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol EntryPointViewInput: class {

    func updateProgress(_ progress: Float)
    func setupInitialState()
}
