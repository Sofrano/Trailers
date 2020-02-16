//
//  CastingListCastingListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

// MARK: Class

class CastingListPresenter {

    weak var view: CastingListViewInput?
    var interactor: CastingListInteractorInput?
    var router: CastingListRouterInput?
    
    private var vmCreator: CastingListViewModelCreator = CastingListViewModelDefault()
    private var movieId: MovieID?
    
    private func fetchCasts() {
        guard let id = movieId else {
            router?.showAlert(withMessage: "Data error")
            return
        }
        router?.showLoading()
        interactor?.fetchCasts(for: id)
    }
    
}

// MARK: Module Input

extension CastingListPresenter: CastingListModuleInput {
    
    func configure(with movieId: MovieID) {
        self.movieId = movieId
    }
    
}

// MARK: View Output

extension CastingListPresenter: CastingListViewOutput {

    func viewIsReady() {
        view?.setupInitialState()
        fetchCasts()
    }
    
}

// MARK: Interactor Output

extension CastingListPresenter: CastingListInteractorOutput {
   
    func onFetchedCasts(_ casts: [DTOCast]) {
        let viewModel = vmCreator.createViewModel(with: casts)
        view?.update(with: viewModel)
    }
    
}
