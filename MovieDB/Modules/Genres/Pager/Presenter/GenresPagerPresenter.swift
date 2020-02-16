//
//  GenresPagerGenresPagerPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class GenresPagerPresenter {

    weak var view: GenresPagerViewInput?
    var interactor: GenresPagerInteractorInput?
    var router: GenresPagerRouterInput?
    
    private func fetchGenres() {
        router?.showLoading()
        interactor?.fetchGenres()
    }
    
}

extension GenresPagerPresenter: GenresPagerModuleInput {}

extension GenresPagerPresenter: GenresPagerViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        fetchGenres()
    }
    
}

extension GenresPagerPresenter: GenresPagerInteractorOutput {
    
    func onFetchedGenres(_ genres: [DTOGenre]) {
        guard let pages = router?.createPages(with: genres) else { return }
        view?.update(withPages: pages)
    }

}
