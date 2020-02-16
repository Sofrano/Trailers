//
//  GenreListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.


import Foundation

// MARK: - Class

class GenreListPresenter {

    weak var view: GenreListViewInput?
    var interactor: GenreListInteractorInput?
    var router: GenreListRouterInput?
    private var genre: DTOGenre!
    private lazy var vmCreator: GenreListViewModelCreator = GenreListViewModelDefault(output: self)
    
    private func fetchDiscoverMedia() {
        router?.showLoading()
        interactor?.fetchMovies(genreId: genre.id)
    }
    
}

// MARK: - Module Input

extension GenreListPresenter: GenreListModuleInput {
    
    func configure(with genre: DTOGenre) {
        self.genre = genre
    }
    
}

// MARK: - View Output

extension GenreListPresenter: GenreListViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        fetchDiscoverMedia()
    }
    
}

// MARK: - ViewModel Output

extension GenreListPresenter: GenreListViewModelOutput {
    
    func stateChanged(viewModel: GenreListViewModel) {
        view?.update(with: viewModel)
    }
    
    func openMovie(_ movie: DTOMovie) {
        router?.presentMovie(movie)
    }
    
}

// MARK: - Interactor Output

extension GenreListPresenter: GenreListInteractorOutput {
    
    func onFetchedMovies(_ movies: [DTOMovie]) {
        let viewModel = vmCreator.createViewModel(movies: movies)
        view?.update(with: viewModel)
    }
    
}
