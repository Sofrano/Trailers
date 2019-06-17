//
//  GenresGenresNetworkService.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 29/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Result
import RxSwift
import Moya
import PromiseKit

class GenresNetworkService {
    
    lazy private var provider = APIProvider<GenresSpecification>().provider
    let disposeBag = DisposeBag()
    
    func getGenres() -> Promise<[DTOGenre]> {
        return Promise { seal in
            provider.rx.request(GenresSpecification.getGenres)
                .map([DTOGenre].self, atKeyPath: "genres")
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
