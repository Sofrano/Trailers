//
//  CastingListCastingListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class CastingListPresenter: CastingListModuleInput {

    weak var view: CastingListViewInput?
    var interactor: CastingListInteractorInput?
    var router: CastingListRouterInput?

    private var movieId: MovieID?
    
    
    func viewIsReady() {
        view?.setupInitialState()
        interactor?.fetchCredits(for: movieId ?? 0)
    }
    
    func createViewModel(casts: [DTOCast]) -> CastingListViewModel {
        let viewModel = CastingListViewModel()
        casts.forEach { (cast) in
            let url = cast.profilePath?.url(size: EBackdropSize.w300)
            let castViewModel = CastCellViewModel(character: cast.character,
                                                  name: cast.name,
                                                  imageURL: url)
            viewModel.castViewModels.append(castViewModel)
        }
        return viewModel
    }
}

extension CastingListPresenter: CastingListViewOutput {
    
    func configure(with movieId: MovieID) {
        self.movieId = movieId
    }
    
}

extension CastingListPresenter: CastingListInteractorOutput {
    
    func onFetchedCredits(_ credits: DTOCredits) {
        let casts = (credits.cast ?? []).filter { $0.profilePath != nil }
        let viewModel = createViewModel(casts: casts)
        view?.update(with: viewModel)
    }
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
