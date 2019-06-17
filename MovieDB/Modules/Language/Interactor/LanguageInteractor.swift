//
//  EntryPointEntryPointInteractor.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
import PromiseKit
class LanguageInteractor: LanguageInteractorInput {
    
    weak var output: LanguageInteractorOutput?
    let service = ConfigurationNetworkService()
    
    func fetchLanguages() {
        service.getLanguages()
            .done { self.output?.onFetchedLanguages($0) }
            .catch { self.output?.onError($0) }
            .finally { self.output?.onComplete() }
    }
}
