//
//  MovieWallMovieWallInteractorInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol MovieWallInteractorInput {
    
    func fetchWall(for movieId: MovieID)
    
}
