//
//  MovieWallMovieWallRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol MovieWallRouterInput: AlertRoutable, LoadingRoutable, PresentRoutable {

    func openVideo(_ video: DTOVideo)
    func openOverview(_ overview: String, title: String)
    func openImageGallery(with photos: [DTOPoster])
    func openVideoGallery(for movieId: MovieID)
    func openCastGallery(for movieId: MovieID)
    func openPhotoSlider(with images: [URL],
                         currentPage: Int)
    
}
