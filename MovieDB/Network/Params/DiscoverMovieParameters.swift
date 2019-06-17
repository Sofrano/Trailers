//
//  DiscoverMovieParameters.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 29/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Request params https://developers.themoviedb.org/3/discover/movie-discover

import Foundation

class DiscoverMediaParameters: Encodable {
    
    // MARK: - Variables
    
    var genres: [GenreID] = [] {
        didSet {
            withGenres = genres.compactMap { String($0) }.joined(separator: ",")
        }
    }
    
    // MARK: - Encodable Variables
    
    private var withGenres: String?
    var sortBy: SortBy?
    var page: Int = 1
    
    enum CodingKeys: String, CodingKey {
        case sortBy
        case page
        case withGenres
    }
    
}



