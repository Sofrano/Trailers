//
//  MovieWallMovieWallRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol MovieWallRouterInput: AlertRoutable, LoadingRoutable, PresentRoutable {

    func presentVideo(_ video: DTOVideo)
    func presentOverview(_ overview: String, title: String)
    func presentImageGallery(with photos: [DTOPoster])
    func presentVideoGallery(for movieId: MovieID)
    func presentCastGallery(for movieId: MovieID)
    func presentPhotoSlider(with images: [URL],
                         currentPage: Int)
    
}
