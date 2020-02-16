//
//  CastingListCastingListInteractorInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol CastingListInteractorInput {
    
    /// Fetch information about actors who starred in the film
    ///
    /// - parameter movieId: Movie identificator
    func fetchCasts(for movieId: MovieID)
    
}
