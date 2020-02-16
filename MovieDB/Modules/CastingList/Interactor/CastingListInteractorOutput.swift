//
//  CastingListCastingListInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol CastingListInteractorOutput: class, InteractorOutput {
    
    /// Movie credits
    ///
    /// The function will be called by the interactor when the data is received
    /// - parameter credits: The information contains information about the actors who starred
    /// in the film and the production team
    func onFetchedCasts(_ casts: [DTOCast])
}
