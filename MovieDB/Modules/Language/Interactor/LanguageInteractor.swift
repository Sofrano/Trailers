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
    
    var userLanguage: String? {
        return RSettings.language
    }
    
    var defaultLanguage: String {
        return userLanguage ?? NSLocale.current.languageCode ?? ""
    }
    
    func fetchLanguages() {
        service.getLanguages()
            .map {
                // Delete language in the list that is “unknown”
                $0.filter { $0.iso6391 != "xx" }
            }
            .done { self.output?.onFetchedLanguages($0) }
            .catch { self.output?.onError($0) }
            .finally { self.output?.onComplete() }
    }
    
    func setLanguage(_ language: DTOLanguage) {
        RSettings.language = language.iso6391 ?? "en"
    }
    
}
