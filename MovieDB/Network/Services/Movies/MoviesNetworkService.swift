//
//  MoviesMoviesNetworkService.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Result
import RxSwift
import Moya
import PromiseKit

class MoviesNetworkService {
    
    lazy private var provider = APIProvider<MoviesSpecification>().provider
    let disposeBag = DisposeBag()
    
    private var decoder = JSONDecoder.snakeCaseStrategy
    
    func getMovieDetails(_ params: MovieDetailsParameters) -> Promise<DTOMovie> {
        return Promise { seal in
            provider.rx.request(MoviesSpecification.getMovieDetails(params))
                .map(DTOMovie.self, using: decoder)
                .subscribe { (event) in
                    switch event {
                    case .success(let response):
                        seal.fulfill(response)
                    case let .error(error):
                        seal.reject(error)
                    }
                }
                .disposed(by: disposeBag)
        }
    }
    
    func getImages(for movieId: MovieID,
                   languages: [ELanguage]) -> Promise<DTOImages> {
        return Promise { seal in
            provider.rx.request(MoviesSpecification.getImages(for: movieId, languages: languages))
                .map(DTOImages.self, using: decoder)
                .subscribe { (event) in
                    switch event {
                    case .success(let response):
                        seal.fulfill(response)
                    case let .error(error):
                        seal.reject(error)
                    }
                }
                .disposed(by: disposeBag)
        }
    }
    
    func getVideos(for movieId: MovieID,
                   languages: [ELanguage]) -> Promise<DTOVideos> {
        return Promise { seal in
            provider.rx.request(MoviesSpecification.getVideos(for: movieId, languages: languages))
                .map(DTOVideos.self, using: decoder)
                .subscribe { (event) in
                    switch event {
                    case .success(let response):
                        seal.fulfill(response)
                    case let .error(error):
                        seal.reject(error)
                    }
                }
                .disposed(by: disposeBag)
        }
    }
    
    func getCredits(for movieId: MovieID) -> Promise<DTOCredits> {
        return Promise { seal in
            provider.rx.request(MoviesSpecification.getCredits(for: movieId))
                .map(DTOCredits.self, using: decoder)
                .subscribe { (event) in
                    switch event {
                    case .success(let response):
                        seal.fulfill(response)
                    case let .error(error):
                        seal.reject(error)
                    }
                }
                .disposed(by: disposeBag)
        }
    }
    
}
