//
//  GenreListGenreListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
import RxSwift

class GenreListPresenter: GenreListModuleInput {

    weak var view: GenreListViewInput?
    var interactor: GenreListInteractorInput?
    var router: GenreListRouterInput?

    private var genre: DTOGenre?
    private var params = DiscoverMediaParameters()
    
    private func fetchDiscoverMedia() {
        params.genres = [genre?.id].compactMap { $0 }
        router?.showLoading()
        interactor?.fetchDiscover(with: params)
    }
    
    func configure(with genre: DTOGenre?) {
        self.genre = genre
    }
    
    func createViewModel(movies: [DTOMovie]) -> GenreListViewModel {
        let posters = movies.map { $0.posterPath?.url(size: EPosterSize.w342) }.compactMap { $0 }
        let imageCollectionViewModel = ImageCollectionViewModel(imageURLs: posters)
        let model = GenreListViewModel(imageCollectionViewModel: imageCollectionViewModel)
        imageCollectionViewModel.observeAction { (action) in
            switch(action) {
            case .selectItem(let index):
                let movie = movies[index]
                model.currentPosterIndex = index
                model.movieShortDescriptionViewModel = self.createMovieShortViewModel(movie: movie)
                model.textViewModel = self.createTextViewModel(movie: movie)
                self.view?.update(with: model)
            }
        }
        imageCollectionViewModel.invoke(action: .selectItem(index: 0))
        return model
    }
    
    func createTextViewModel(movie: DTOMovie) -> TextCellViewModel {
        let textViewModel = TextCellViewModel(text: movie.overview ?? "")
        return textViewModel
    }
    
    func createMovieShortViewModel(movie: DTOMovie) -> MovieShortDescriptionCellViewModel {
        let date = Date(fromString: movie.releaseDate ?? "", format: .isoDate)
        let year = date?.toString(format: .isoYear) ?? ""
        let genreNames = ConfigurationManager.genres.compactMap { (movie.genreIds?.contains($0.id ?? 0) ?? false) ? $0.name?.uppercaseFirstLetter() : nil }.joined(separator: ", ")
        
        let model = MovieShortDescriptionCellViewModel(title: movie.title ?? "",
                                                       year: year,
                                                       genreNames: genreNames,
                                                       voteAverage: movie.voteAverage ?? 0)
            .observeAction { (actions) in
                switch actions {
                case .click:
                    self.router?.openMedia(movie)
                }
        }
        
        return model
    }
}

extension GenreListPresenter: GenreListViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        fetchDiscoverMedia()
    }
    
    func openMedia(_ media: DTOMovie) {
        router?.openMedia(media)
    }
    
}

extension GenreListPresenter: GenreListInteractorOutput {
    
    func onFetchedDiscoverMedia(_ discoverMedia: DTODiscoverMedia) {
        view?.update(with: createViewModel(movies: discoverMedia.results ?? []))
        //view?.update(with: discoverMedia.results ?? [])
    }
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
