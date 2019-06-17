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
    
    func onFetchedConfiguration(_ configuration: DTOConfiguration) {
        ConfigurationManager.image = configuration.image
    }
    
    func onChangeProgress(_ progress: Float) {
        view?.updateProgress(progress)
        if progress == 1.0 {
            router?.openGenresList()
        }
    }
    
    func onFetchedGenres(_ genres: [DTOGenre]) {
        ConfigurationManager.genres = genres
    }
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
