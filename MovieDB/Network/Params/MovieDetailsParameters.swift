//
//  MovieDetailsParameters.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Request params https://developers.themoviedb.org/3/movies/get-movie-details

import Foundation

struct MovieDetailsParameters: Encodable {
    var movieId: MovieID?
    var propertyKeys: [EPropertyKey] = [] {
        didSet {
            updateAppendToResponse()
        }
    }
    private var appendToResponse: String?
    
    private mutating func updateAppendToResponse() {
        appendToResponse = propertyKeys.map { $0.rawValue }.joined(separator: ",")
    }
    
    init(movieId: MovieID, propertyKeys: [EPropertyKey] = []) {
        self.movieId = movieId
        self.propertyKeys = propertyKeys
        updateAppendToResponse()
    }
    
    enum CodingKeys: String, CodingKey {
        case appendToResponse
    }
    
}
