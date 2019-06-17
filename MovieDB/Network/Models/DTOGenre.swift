//
//  DTOGenre.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 29/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
// https://developers.themoviedb.org/3/genres/get-movie-list

import Foundation

typealias GenreID = UInt

struct DTOGenre: Decodable {
    let id: GenreID?
    let name: String?
}
