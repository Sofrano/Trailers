//
//  SortType.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 29/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  API themoviedb sort types

import Foundation

public typealias SortBy = String

enum ESortOrderType: String {
    case ascending = "asc"
    case descending = "desc"
}

enum ESortType: String {
    case popularity
    case releaseDate = "release_date"
    case revenue
    case primaryReleaseDate = "primary_release"
    case originalTitle = "original_title"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    
    
    /**
     Creates sort parameter for an API request
     
     - Parameter order: ascending/descending
     - Returns: String for
     **/
    func withOrder(_ order: ESortOrderType) -> SortBy {
        return "\(self.rawValue).\(order.rawValue)"
    }
    
}
