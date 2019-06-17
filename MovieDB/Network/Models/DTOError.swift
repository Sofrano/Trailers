//
//  DTOError.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
// https://www.themoviedb.org/documentation/api/status-codes

import Foundation

struct DTOError: Decodable {
    var statusCode: Int?
    var statusMessage: String?
}
