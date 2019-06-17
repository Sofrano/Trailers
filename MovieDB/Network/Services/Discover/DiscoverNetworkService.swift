//
//  DiscoverDiscoverNetworkService.swift
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

class DiscoverNetworkService {
    
    lazy private var provider = APIProvider<DiscoverSpecification>().provider
    let disposeBag = DisposeBag()
    
    private var decoder = JSONDecoder.snakeCaseStrategy
    
    func getDiscoverMedia(_ params: DiscoverMediaParameters) -> Promise<DTODiscoverMedia> {
        return Promise { seal in
            provider.rx.request(DiscoverSpecification.getDiscoverMedia(params))
                .map(DTODiscoverMedia.self, using: decoder)
                .subscribe { (event) in
                    switch event {
                    case let .success(response):
                        seal.fulfill(response)
                    case let .error(error):
                        seal.reject(error)
                    }
                }
                .disposed(by: disposeBag)
        }
    }
    
}
