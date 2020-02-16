//
//  GenresPagerGenresPagerInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol GenresPagerInteractorOutput: class, InteractorOutput {

    /// All movie genres
    ///
    /// The function will be called by the interactor when the data is received
    /// - parameter genres: list of genres
    func onFetchedGenres(_ genres: [DTOGenre])
    
}
