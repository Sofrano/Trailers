//
//  TextListTextListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class TextListPresenter: TextListModuleInput {

    weak var view: TextListViewInput?
    var interactor: TextListInteractorInput?
    var router: TextListRouterInput?

    private var items: [String] = []
    
    func configure(with items: [String]) {
        self.items = items
    }
    
}

extension TextListPresenter: TextListViewOutput {

    func viewIsReady() {
        view?.setupInitialState()
        let viewModel = TextListViewModel(textList: items)
        view?.update(with: viewModel)
    }
    
}

extension TextListPresenter: TextListInteractorOutput {
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
