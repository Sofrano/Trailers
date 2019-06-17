//
//  EntryPointEntryPointViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol LanguageViewInput: class {

    func scrollToIndex(_ index: Int)
    func update(with languageListViewModel: LanguageListViewModel)
    func setupInitialState()
}
