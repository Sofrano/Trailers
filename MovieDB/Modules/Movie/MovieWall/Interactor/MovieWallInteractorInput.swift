//
//  MovieWallMovieWallInteractorInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol MovieWallInteractorInput {

    /*func fetchMovieDetails(_ params: MovieDetailsParameters)
    func fetchImages(for movieId: MovieID)
    func fetchCredits(for movieId: MovieID)
    func fetchVideos(for movieId: MovieID)*/
    func fetchWall(for movieId: MovieID)
}
