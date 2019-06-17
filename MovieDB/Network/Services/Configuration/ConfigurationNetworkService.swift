//
//  ConfigurationConfigurationNetworkService.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Result
import RxSwift
import Moya
import PromiseKit

class ConfigurationNetworkService {
    
    lazy private var provider = APIProvider<ConfigurationSpecification>().provider
    let disposeBag = DisposeBag()
    
    private var decoder = JSONDecoder.snakeCaseStrategy
    
    func getConfiguration() -> Promise<DTOConfiguration> {
        return Promise { seal in
            provider.rx.request(ConfigurationSpecification.getAPIConfiguration)
                .map(DTOConfiguration.self, using: decoder)
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
    
    func getLanguages() -> Promise<[DTOLanguage]> {
        return Promise { seal in
        provider.rx.request(ConfigurationSpecification.getLanguages)
            .map([DTOLanguage].self, using: decoder)
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
