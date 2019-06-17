//
//  ImageType.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  API TheMovieDB enums

import Foundation

public enum EBackdropSize: String, Codable {
    case w300
    case w780
    case w1280
    case original
}

public enum ELogoSize: String, Codable {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

public enum EPosterSize: String, Codable {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

public enum EProfileSize: String, Codable {
    case w92
    case w185
    case w300
    case original
}

public enum EStillSize: String, Codable {
    case w92
    case w185
    case w300
    case original
}
