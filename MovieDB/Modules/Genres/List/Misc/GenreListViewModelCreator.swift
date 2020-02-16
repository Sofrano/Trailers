//
//  GenreListViewModelCreator.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/02/2020.
//  Copyright © 2020 SimpleCode. All rights reserved.
//

import Foundation

protocol GenreListViewModelOutput: class {
    func openMovie(_ movie: DTOMovie)
    func stateChanged(viewModel: GenreListViewModel)
}

protocol GenreListViewModelCreator {
    
    func createViewModel(movies: [DTOMovie]) -> GenreListViewModel
}

class GenreListViewModelDefault: GenreListViewModelCreator {
    
    weak var output: GenreListViewModelOutput?
    
    init(output: GenreListViewModelOutput) {
        self.output = output
    }
    
    func createViewModel(movies: [DTOMovie]) -> GenreListViewModel {
        let posters = movies.map { $0.posterPath?.url(size: EPosterSize.w342) }.compactMap { $0 }
        let imageCollectionViewModel = ImageCollectionViewModel(imageURLs: posters)
        let model = GenreListViewModel(imageCollectionViewModel: imageCollectionViewModel)
        imageCollectionViewModel.observeAction { [weak self] (action) in
            guard let self = self else { return }
            switch(action) {
            case .selectItem(let index):
                let movie = movies[index]
                model.currentPosterIndex = index
                model.movieShortDescriptionViewModel = self.createMovieShortViewModel(movie: movie)
                model.textViewModel = self.createTextViewModel(movie: movie)
                self.output?.stateChanged(viewModel: model)
            }
        }
        imageCollectionViewModel.invoke(action: .selectItem(index: 0))
        return model
    }
    
    private func createTextViewModel(movie: DTOMovie) -> TextCellViewModel {
        let textViewModel = TextCellViewModel(text: movie.overview ?? "")
        return textViewModel
    }
    
    private func createMovieShortViewModel(movie: DTOMovie) -> MovieShortDescriptionCellViewModel {
        let date = Date(fromString: movie.releaseDate ?? "", format: .isoDate)
        let year = date?.toString(format: .isoYear) ?? ""
        let genreNames = ConfigurationManager.genres.compactMap { (movie.genreIds?.contains($0.id) ?? false) ? $0.name?.uppercaseFirstLetter() : nil }.joined(separator: ", ")
        
        let model = MovieShortDescriptionCellViewModel(title: movie.title ?? "",
                                                       year: year,
                                                       genreNames: genreNames,
                                                       voteAverage: movie.voteAverage ?? 0)
            .observeAction { [weak self] (actions) in
                guard let self = self else { return }
                switch actions {
                case .click:
                    self.output?.openMovie(movie)
                }
        }
        
        return model
    }
    
}
