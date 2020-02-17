//
//  LanguageListViewModelCreator.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 17/02/2020.
//  Copyright © 2020 SimpleCode. All rights reserved.
//

import Foundation

protocol LanguageListViewModelOutput: class {
    func selectLanguage(_ language: DTOLanguage)
}

protocol LanguageListViewModelCreator {
    /// Create casting list view model
    ///
    /// - parameter casts: List of casts
    /// - returns: ViewModel for CastList, with list of cell viewModels
    func createViewModel(languages: [DTOLanguage]) -> LanguageListViewModel
}

class LanguageListDefaultViewModelCreator: LanguageListViewModelCreator {
    
    weak var output: LanguageListViewModelOutput?
    
    init(output: LanguageListViewModelOutput) {
        self.output = output
    }
    
    func createViewModel(languages: [DTOLanguage]) -> LanguageListViewModel {
        let langViewModels = languages.map { TextCellViewModel(text: $0.title) }
        let viewModel = LanguageListViewModel(languages: langViewModels)
        viewModel.onSelectLanguage = { [weak self] index in
            guard let self = self,
                let language = languages[safe: index] else { return }
            self.output?.selectLanguage(language)
        }
        return viewModel
    }
    
}
