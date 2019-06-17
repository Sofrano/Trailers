//
//  DTOCredits.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 03/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  TheMovieDB API Entity

import Foundation

struct DTOCredits: Decodable {
    let id: Int?
    let cast: [DTOCast]?
    let crew: [DTOCrew]?
}

struct DTOCast: Decodable {
    let castID: Int?
    let character, creditID: String?
    let gender, id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?
}

struct DTOCrew: Decodable {
    let creditID, department: String?
    let gender, id: Int?
    let job, name: String?
    let profilePath: String?
}
