//
//  EntryPointEntryPointPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

// MARK: - Class

class EntryPointPresenter {

    weak var view: EntryPointViewInput?
    var interactor: EntryPointInteractorInput?
    var router: EntryPointRouterInput?

}

// MARK: - Module Input

extension EntryPointPresenter: EntryPointModuleInput {}

// MARK: - View Output

extension EntryPointPresenter: EntryPointViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        interactor?.fetchData()
    }
    
}

// MARK: - Interactor Output

extension EntryPointPresenter: EntryPointInteractorOutput {
    
    func onChangeProgress(_ progress: Float) {
        view?.updateProgress(progress)
    }
    
    func onComplete() {
        router?.hideLoading()
        router?.presentGenreList()
    }

}
