//
//  EntryPointEntryPointInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol EntryPointInteractorOutput: class {

    func onError(_ error: Error?)
    func onComplete()
    func onFetchedConfiguration(_ configuration: DTOConfiguration)
    func onFetchedGenres(_ genres: [DTOGenre])
    func onChangeProgress(_ progress: Float)
    
}
