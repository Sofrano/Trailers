//
//  EntryPointEntryPointInteractor.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import PromiseKit

class EntryPointInteractor: EntryPointInteractorInput {
    
    weak var output: EntryPointInteractorOutput?
    let service = ConfigurationNetworkService()
    let genresService = GenresNetworkService()
    
    // We request all the necessary data - configuration, genres
    // and give data on the progress of loading
    //
    // [weak self] - That documentation is merely saying that
    // you don't have to worry about PromiseKit introducing
    // "strong reference cycles" (previously known as "retain cycles")
    // because when the promise is fulfilled and the block finishes
    // running, those strong references are automatically resolved for
    // you. The choice of strong vs weak references is solely up to you.
    func fetchData() {
        output?.onChangeProgress(0.1)
        service.getConfiguration()
            .done {
                ConfigurationManager.image = $0.image
                self.output?.onFetchedConfiguration($0)
            }
            .done { _ in self.output?.onChangeProgress(0.5) }
            .then { self.genresService.getGenres() }
            .done {
                ConfigurationManager.genres = $0
                self.output?.onFetchedGenres($0)
            }
            .catch { self.output?.onError($0) }
            .finally {
                self.output?.onChangeProgress(1.0)
                self.output?.onComplete()
        }
        
    }
    
}
