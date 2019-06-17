//
//  MovieWallMovieWallInteractor.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import PromiseKit
class MovieWallInteractor: MovieWallInteractorInput {
    
    weak var output: MovieWallInteractorOutput?
    let movieService = MoviesNetworkService()
    
    // request data for a wall from different API
    func fetchWall(for movieId: MovieID) {
        let params = MovieDetailsParameters(movieId: movieId,
                                            propertyKeys: [.title, .budget, .genres])
        let promiseImage = movieService.getImages(for: movieId, languages: [.application, .en, .null])
        let promiseMovieDetails = movieService.getMovieDetails(params)
        let promiseApplicationMovies = movieService.getVideos(for: movieId,
                                                   languages: [.application])
        let promiseEnMovies = movieService.getVideos(for: movieId,
                                                     languages: [.en])
        let promiseCredits = movieService.getCredits(for: movieId)
        
        var promises = [promiseImage.asVoid(),
                        promiseMovieDetails.asVoid(),
                        promiseCredits.asVoid(),
                        promiseApplicationMovies.asVoid()
        ]
        if RSettings.language != ELanguage.en.languageIdentifier {
            promises.append(promiseEnMovies.asVoid())
        }
        let movieWall = MovieWall()
        when(fulfilled: promises)
            .done { (_) in
                movieWall.images = promiseImage.value?.backdrops
                movieWall.movie = promiseMovieDetails.value
                movieWall.cast = promiseCredits.value?.cast
                movieWall.videos = promiseApplicationMovies.value
                self.output?.onFetchedWall(movieWall)
            }
            .catch { self.output?.onError($0) }
            .finally { self.output?.onComplete() }
    }
    
}
