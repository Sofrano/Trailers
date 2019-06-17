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
    
    func fetchData() {
        output?.onChangeProgress(0.1)
        service.getConfiguration()
            .done { self.output?.onFetchedConfiguration($0) }
            .done { _ in self.output?.onChangeProgress(0.5) }
            .then { self.genresService.getGenres() }
            .done { self.output?.onFetchedGenres($0) }
            .catch { self.output?.onError($0) }
            .finally {
                self.output?.onChangeProgress(1.0)
                self.output?.onComplete()
        }
        
    }
    
}
