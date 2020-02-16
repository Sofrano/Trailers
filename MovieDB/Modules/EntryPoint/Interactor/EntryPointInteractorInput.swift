//
//  EntryPointEntryPointInteractorInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol EntryPointInteractorInput {

    /// We request all the necessary data - configuration, genres
    /// and give data on the progress of loading
    func fetchData()
    
}
