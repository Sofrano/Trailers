//
//  DTOConfiguration.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

struct DTOConfiguration: Decodable {
    let image: DTOImageConfiguration?
    let changeKeys: [String]?
    
    enum CodingKeys: String, CodingKey {
        case image = "images"
        case changeKeys
    }
    
}

struct DTOImageConfiguration: Decodable {
    let baseUrl: String?
    let secureBaseUrl: String?
    let backdropSizes: [String]?
    let logoSizes: [String]?
    let posterSizes: [String]?
    let profileSizes: [String]?
    let stillSizes: [String]?
}
