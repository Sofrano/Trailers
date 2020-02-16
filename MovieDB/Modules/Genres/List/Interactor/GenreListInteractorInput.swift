//
//  GenreListInteractorInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol GenreListInteractorInput {

    /// Fetch movies
    func fetchMovies(genreId: GenreID)
    
}
