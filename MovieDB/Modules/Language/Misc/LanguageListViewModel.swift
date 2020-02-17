//
//  LanguageListViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

class LanguageListViewModel {
    var languages: [TextCellViewModel]
    var onSelectLanguage: (_ atIndex: Int) -> Void = {_ in}
    var scrollToIndex: ((_ index: Int) -> Void)?
    
    private var sourceLanguages: [TextCellViewModel] = []
    
    func filterLanguages(with query: String?) {
        guard let query = query?.uppercased() else {
            languages = sourceLanguages
            return
        }
        languages = sourceLanguages.filter {
            $0.text.uppercased().contains(query)
        }
    }
    
    init(languages: [TextCellViewModel]) {
        self.languages = languages
        self.sourceLanguages = languages
    }
}
