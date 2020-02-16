//
//  GenresPagerGenresPagerPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

// MARK: - Class

class GenresPagerPresenter {

    weak var view: GenresPagerViewInput?
    var interactor: GenresPagerInteractorInput?
    var router: GenresPagerRouterInput?
    
    private func fetchGenres() {
        router?.showLoading()
        interactor?.fetchGenres()
    }
    
}

// MARK: - Module Input

extension GenresPagerPresenter: GenresPagerModuleInput {}

// MARK: - View Output

extension GenresPagerPresenter: GenresPagerViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        fetchGenres()
    }
    
}

// MARK: - Interactor Output

extension GenresPagerPresenter: GenresPagerInteractorOutput {
    
    func onFetchedGenres(_ genres: [DTOGenre]) {
        guard let pages = router?.createPages(with: genres) else { return }
        view?.update(withPages: pages)
    }

}
