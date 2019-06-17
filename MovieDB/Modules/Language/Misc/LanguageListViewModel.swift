//
//  LanguageListViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

class LanguageListViewModel {
    let languages: [TextCellViewModel]
    var onSelectLanguage: (_ atIndex: Int) -> Void = {_ in}
    
    init(languages: [TextCellViewModel]) {
        self.languages = languages
    }
}
