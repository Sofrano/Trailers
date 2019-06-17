//
//  DiscoverMedia.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
// https://developers.themoviedb.org/3/discover/movie-discover

import Foundation

struct DTODiscoverMedia: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [DTOMovie]?
}

