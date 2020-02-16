//
//  CastingListCastingListInteractor.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import PromiseKit

class CastingListInteractor: CastingListInteractorInput {

    weak var output: CastingListInteractorOutput?
    private let service = MoviesNetworkService()
    
    func fetchCasts(for movieId: MovieID) {
        service.getCredits(for: movieId)
            .done { (credits) in
                /// Filter only the necessary data
                let casts = (credits.cast ?? []).filter { $0.profilePath != nil }
                self.output?.onFetchedCasts(casts)
            }
            .catch { self.output?.onError($0) }
            .finally { self.output?.onComplete() }
    }
    
}
