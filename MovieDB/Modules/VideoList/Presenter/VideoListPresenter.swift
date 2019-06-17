//
//  VideoListVideoListPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class VideoListPresenter: VideoListModuleInput {

    weak var view: VideoListViewInput?
    var interactor: VideoListInteractorInput?
    var router: VideoListRouterInput?

    private var movieId: MovieID?
    
    func viewIsReady() {
        view?.setupInitialState()
        router?.showLoading()
        interactor?.fetchVideos(for: movieId ?? 0)
    }
    
    func configure(with movieId: MovieID) {
        self.movieId = movieId
    }
    
    func openVideo(_ video: DTOVideo) {
        router?.openVideo(video)
    }
    
    func createViewModel(_ videos: [DTOVideo]) -> VideoListViewModel {
        let viewModel = VideoListViewModel()
        videos.forEach { (video) in
            let playerViewModel = YTPlayerCellViewModel(videoId: video.videoId,
                                                  name: video.name ?? "")
                .observeAction({ (action) in
                    switch action {
                    case .click:
                        self.router?.openVideo(video)
                    }
                })
            viewModel.listViewModel.append(playerViewModel)
        }
        return viewModel
    }
    
}

extension VideoListPresenter: VideoListViewOutput {

}

extension VideoListPresenter: VideoListInteractorOutput {
    
    func onFetchedVideos(_ videos: [DTOVideo]) {
        let viewModel = createViewModel(videos)
        view?.update(with: viewModel)
    }
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }

}
