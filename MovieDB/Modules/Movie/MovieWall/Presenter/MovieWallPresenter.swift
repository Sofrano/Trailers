//
//  MovieWallMovieWallPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

// MARK: - Class

class MovieWallPresenter {
    
    weak var view: MovieWallViewInput?
    var interactor: MovieWallInteractorInput?
    var router: MovieWallRouterInput?
    
    private lazy var vmCreator: MovieWallViewModelCreator = MovieWallDefaultViewModelCreator(output: self)
    private var movieId: MovieID!
    private var movieWall: MovieWall = MovieWall()
    
}

// MARK: - Module Input

extension MovieWallPresenter: MovieWallModuleInput {
    
    func configure(with movieId: MovieID) {
        self.movieId = movieId
    }
    
}

// MARK: - View Output

extension MovieWallPresenter: MovieWallViewOutput {
    
    func viewIsReady() {
        self.movieId = movieId ?? 0
        view?.setupInitialState()
        router?.showLoading()
        interactor?.fetchWall(for: self.movieId)
    }
    
}

// MARK: - ViewModel Output

extension MovieWallPresenter: MovieWallViewModelOutput {
    
    func imageGallerySeeAll() {
        guard let images = movieWall.images else { return }
        router?.presentImageGallery(with: images)
    }
    
    func imageGallerySelectItem(atIndex: Int) {
        let images = movieWall.imageURLs
        router?.presentPhotoSlider(with: images, currentPage: atIndex)
    }
    
    func castsSeeAll() {
        router?.presentCastGallery(for: movieId)
    }
    
    func castsSelectItem(atIndex: Int) {
        print("TODO")
    }
    
    func videoSeeAll() {
        router?.presentVideoGallery(for: movieId)
    }
    
    func videoSelectItem(atIndex: Int) {
        guard let videoList = movieWall.videos?.results,
            let video = videoList[safe: atIndex] else { return }
        router?.presentVideo(video)
    }
    
    func toggleNotification() {
        print("TODO")
    }
    
    func overviewSeeAll() {
        let overview = movieWall.movie?.overview ?? ""
        router?.presentOverview(overview,
                             title: movieWall.movie?.originalTitle ?? "")
    }
    
    func toggleWatchlist() {
        print("TODO")
    }
    
}

// MARK: - Interactor Output

extension MovieWallPresenter: MovieWallInteractorOutput {
    
    func onFetchedWall(_ wall: MovieWall) {
        movieWall = wall
        let viewModel = vmCreator.createViewModel(movieWall: wall)
        view?.update(with: viewModel)
    }
    
}
