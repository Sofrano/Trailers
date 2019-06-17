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
    let service = MoviesNetworkService()
    
    func fetchCredits(for movieId: MovieID) {
        service.getCredits(for: movieId)
            .done { self.output?.onFetchedCredits($0) }
            .catch { self.output?.onError($0) }
            .finally { self.output?.onComplete() }
    }
    
}
