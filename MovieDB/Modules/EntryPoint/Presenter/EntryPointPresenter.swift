//
//  EntryPointEntryPointPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class EntryPointPresenter: EntryPointModuleInput {

    weak var view: EntryPointViewInput?
    var interactor: EntryPointInteractorInput?
    var router: EntryPointRouterInput?

    func viewIsReady() {
        view?.setupInitialState()
        interactor?.fetchData()
    }
}

extension EntryPointPresenter: EntryPointViewOutput {

}

extension EntryPointPresenter: EntryPointInteractorOutput {
    
    func onChangeProgress(_ progress: Float) {
        view?.updateProgress(progress)
    }
    
    func onComplete() {
        router?.hideLoading()
        router?.presentGenreList()
    }

}
