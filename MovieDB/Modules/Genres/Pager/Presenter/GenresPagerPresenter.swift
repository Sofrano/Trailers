//
//  GenresPagerGenresPagerPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class GenresPagerPresenter: GenresPagerModuleInput {

    weak var view: GenresPagerViewInput?
    var interactor: GenresPagerInteractorInput?
    var router: GenresPagerRouterInput?

    func viewIsReady() {
        view?.setupInitialState()
        fetchGenres()
    }
    
    private func fetchGenres() {
        router?.showLoading()
        interactor?.fetchGenres()
    }
}

extension GenresPagerPresenter: GenresPagerViewOutput {
    
}

extension GenresPagerPresenter: GenresPagerInteractorOutput {
    
    func onFetchedGenres(_ genres: [DTOGenre]) {
        view?.update(with: genres)
    }
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
