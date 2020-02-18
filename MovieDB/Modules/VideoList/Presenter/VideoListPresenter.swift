//
//  VideoListVideoListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

// MARK: - Class

class VideoListPresenter  {

    weak var view: VideoListViewInput?
    var interactor: VideoListInteractorInput?
    var router: VideoListRouterInput?

    private lazy var vmCreator: VideoListViewModelCreator = VideoListDefaultViewModelCreator(output: self)
    private var movieId: MovieID?
    
}

// MARK: - Module Input

extension VideoListPresenter: VideoListModuleInput {
    
    func configure(with movieId: MovieID) {
        self.movieId = movieId
    }
    
}

// MARK: - View Output

extension VideoListPresenter: VideoListViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
        router?.showLoading()
        interactor?.fetchVideos(for: movieId ?? 0)
    }
    
}

// MARK: - ViewModel Output

extension VideoListPresenter: VideoListViewModelOutput {
   
    func selectVideo(_ video: DTOVideo) {
        router?.openVideo(video)
    }

}

// MARK: - Interactor Output

extension VideoListPresenter: VideoListInteractorOutput {
    
    func onFetchedVideos(_ videos: [DTOVideo]) {
        let viewModel = vmCreator.createViewModel(videos)
        view?.update(with: viewModel)
    }

}
