//
//  GenreListInteractor.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
import PromiseKit

class GenreListInteractor: GenreListInteractorInput {
    weak var output: GenreListInteractorOutput?
    let discoverService = DiscoverNetworkService()
    
    func fetchMovies(genreId: GenreID) {
        let params = DiscoverMediaParameters()
        params.genres = [genreId]
        discoverService.getDiscoverMedia(params)
            .compactMap { $0.results }
            .done { self.output?.onFetchedMovies($0) }
            .catch { self.output?.onError($0) }
            .finally { self.output?.onComplete() }
    }
    
}
