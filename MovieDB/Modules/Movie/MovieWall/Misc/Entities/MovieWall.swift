//
//  asdf.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 21/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Combined data model from different API for wall drawing

import Foundation

class MovieWall {
    var movie: DTOMovie?
    var images: [DTOPoster]?
    var imageURLs: [URL] {
        get {
            return (images ?? [])
                .map { $0.filePath?.url(size: EBackdropSize.w780) }
                .compactMap { $0 }
        }
    }
    var videos: DTOVideos?
    var cast: [DTOCast]?
}
