//
//  MovieWallMovieWallPresenter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
import Foundation

class MovieWallPresenter: MovieWallModuleInput {
    
    weak var view: MovieWallViewInput?
    var interactor: MovieWallInteractorInput?
    var router: MovieWallRouterInput?
    
    private var movieId: MovieID!
    private var movieWall: MovieWall = MovieWall()
    
    func configure(with movieId: MovieID) {
        self.movieId = movieId
    }
    
}

extension MovieWallPresenter: MovieWallViewOutput {
    
    func viewIsReady() {
        self.movieId = movieId ?? 0
        view?.setupInitialState()
        router?.showLoading()
        interactor?.fetchWall(for: self.movieId)
    }
    
}

extension MovieWallPresenter: MovieWallInteractorOutput {
    
    func onFetchedWall(_ wall: MovieWall) {
        self.movieWall = wall
        let movieWallViewModel = MovieWallViewModel(headerSliderViewModel: createHeaderSliderViewModel(),
                                                    mediaTitleViewModel: crateMediaTitleViewModel(),
                                                    productionStatusViewModel: createProductionStatusModel(),
                                                    mediaOverviewViewModel: createMediaOverviewViewModel(),
                                                    imagesViewModel: createImageCollectionModel(),
                                                    castViewModel: createCastCollectionModel(),
                                                    videosViewModel: createVideoCollectionModel())
        view?.update(with: movieWallViewModel)
    }
    
    func onError(_ error: Error?) {
        router?.showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    func onComplete() {
        router?.hideLoading()
    }
    
}

extension MovieWallPresenter {
    
    func createImageCollectionModel() -> SectionImageCollectionViewModel {
        let imageURLs = movieWall.imageURLs ?? []
        let imagesViewModel = SectionImageCollectionViewModel(title: R.string.localizable.images(),
                                                              imageURLs: imageURLs)
            .observeAction { (action) in
                switch action {
                case .openDetails:
                    self.openImageGallery()
                case .selectItem(let index):
                    self.openPhotoSlider(with: imageURLs, currentPage: index)
                }
        }
        return imagesViewModel
    }
    
    func createCastCollectionModel() -> CastCollectionViewModel {
        let casts = movieWall.cast?.compactMap {
            CastCellViewModel(character: $0.character, name: $0.name)
            } ?? []
        let castImagesURLs = movieWall.cast?.compactMap { $0.profilePath?.url(size: EBackdropSize.w300)} ?? []
        let castViewModel = CastCollectionViewModel(title: R.string.localizable.cast(),
                                                    imageURLs: castImagesURLs,
                                                    casts: casts)
            .observeAction { (action) in
                switch action {
                case .openDetails:
                    self.openCastGallery()
                case .selectItem(let index):
                    print("TODO: Open cast details at index \(index)")
                }
        }
        return castViewModel
    }
    
    func createVideoCollectionModel() -> SectionImageCollectionViewModel {
        let videos = movieWall.videos?.results?.compactMap { URL(videoId: $0.videoId,
                                                                 quality: .high) } ?? []
        let videosViewModel = SectionImageCollectionViewModel(title: R.string.localizable.video(),
                                                              imageURLs: videos)
            .observeAction { (action) in
                switch action {
                case .openDetails:
                    self.openVideoGallery()
                case .selectItem(let index):
                    if let videos = self.movieWall.videos?.results {
                        self.openVideo(videos[index])
                    }
                }
        }
        return videosViewModel
    }
    
    func createProductionStatusModel() -> ProductionCellViewModel? {
        var productionStatusViewModel: ProductionCellViewModel?
        let releaseDate = Date(fromString: movieWall.movie?.releaseDate ?? "",
                               format: .isoDate)
        if let date = releaseDate, date.timeIntervalSince1970 > Date().timeIntervalSince1970 {
            productionStatusViewModel = ProductionCellViewModel(title: R.string.localizable.productionStatus(),
                                                                value: movieWall.movie?.status ?? "")
                .observeAction({ (action) in
                    switch action {
                    case .setupNotification:
                        print("TODO: Setup notification for movie")
                    }
                })
        }
        return productionStatusViewModel
    }
    
    func createHeaderSliderViewModel() -> ImageCollectionViewModel {
        let headerSliderViewModel = ImageCollectionViewModel(imageURLs: movieWall.imageURLs ?? [])
        return headerSliderViewModel
    }
    
    func createMediaOverviewViewModel() -> MediaOverviewViewModel {
        let mediaOverviewViewModel = MediaOverviewViewModel(text: movieWall.movie?.overview ?? "",
                                                            posterURL: movieWall.movie?.posterPath?.url(size: EPosterSize.w342),
                                                            actionTitle: R.string.localizable.addWatchList())
            .observeAction { (action) in
                switch action {
                case .openDetails:
                    self.selectOverview(self.movieWall.movie?.overview ?? "")
                case .watchlist:
                    print("todo: add to watchlist")
                }
        }
        return mediaOverviewViewModel
    }
    
    func crateMediaTitleViewModel() -> MediaTitleViewModel {
        let lines = [movieWall.movie?.description,
                     movieWall.movie?.genreList].compactMap { $0 }
        let mediaTitleViewModel = MediaTitleViewModel(title: movieWall.movie?.title ?? "",
                                                      lines: lines)
        return mediaTitleViewModel
    }
    
}

extension MovieWallPresenter {
    
    func openVideo(_ video: DTOVideo) {
        router?.openVideo(video)
    }
    
    func selectOverview(_ overview: String) {
        router?.openOverview(overview,
                             title: movieWall.movie?.originalTitle ?? "")
    }
    
    func openImageGallery() {
        if let images = movieWall.images {
            router?.openImageGallery(with: images)
        }
    }
    
    func openVideoGallery() {
        router?.openVideoGallery(for: movieId)
    }
    
    func openCastGallery() {
        router?.openCastGallery(for: movieId)
    }
    
    func openPhotoSlider(with images: [URL], currentPage: Int) {
        router?.openPhotoSlider(with: images,
                                currentPage: currentPage)
    }
    
}
