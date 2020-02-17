//
//  TextListTextListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

// MARK: - Class

class TextListPresenter {

    weak var view: TextListViewInput?
    var interactor: TextListInteractorInput?
    var router: TextListRouterInput?

    private var items: [String] = []
    
}

// MARK: - Module Input

extension TextListPresenter: TextListModuleInput {
    
    func configure(with items: [String]) {
        self.items = items
    }
    
}

// MARK: - View Output

extension TextListPresenter: TextListViewOutput {

    func viewIsReady() {
        view?.setupInitialState()
        let viewModel = TextListViewModel(textList: items)
        view?.update(with: viewModel)
    }
    
}

// MARK: - Interactor Output

extension TextListPresenter: TextListInteractorOutput {}
