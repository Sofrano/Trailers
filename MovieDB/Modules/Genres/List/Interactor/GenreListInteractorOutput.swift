//
//  GenreListInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol GenreListInteractorOutput: class, InteractorOutput {

    /// Movies
    ///
    /// The function will be called by the interactor when the data is received
    /// - parameter movies: list of movie
    func onFetchedMovies(_ movies: [DTOMovie])
    
}
