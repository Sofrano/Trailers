//
//  MovieWallViewModelCreator.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 17/02/2020.
//  Copyright © 2020 SimpleCode. All rights reserved.
//

import Foundation

protocol MovieWallViewModelOutput: class {
    
    func imageGallerySeeAll()
    func imageGallerySelectItem(atIndex: Int)
    func castsSeeAll()
    func castsSelectItem(atIndex: Int)
    func videoSeeAll()
    func videoSelectItem(atIndex: Int)
    func toggleNotification()
    func overviewSeeAll()
    func toggleWatchlist()
    
}

protocol MovieWallViewModelCreator {
    
    func createViewModel(movieWall: MovieWall) -> MovieWallViewModel
    
}

class MovieWallDefaultViewModelCreator: MovieWallViewModelCreator {
    
    weak var output: MovieWallViewModelOutput?
    
    init(output: MovieWallViewModelOutput) {
        self.output = output
    }
    
    func createViewModel(movieWall: MovieWall) -> MovieWallViewModel {
        let imagesVM = createImageCollectionModel(imageURLs: movieWall.imageURLs)
        let castVM = createCastCollectionModel(movieWall: movieWall)
        let videoVM = createVideoCollectionModel(movieWall: movieWall)
        let productVM = createProductionStatusModel(movieWall: movieWall)
        let headerVM = createHeaderSliderViewModel(imageURLs: movieWall.imageURLs)
        let overviewVM = createMediaOverviewViewModel(movieWall: movieWall)
        let titleVM = crateMediaTitleViewModel(movieWall: movieWall)
        
        let viewModel = MovieWallViewModel(headerSliderViewModel: headerVM,
                                           mediaTitleViewModel: titleVM,
                                           productionStatusViewModel: productVM,
                                           mediaOverviewViewModel: overviewVM,
                                           imagesViewModel: imagesVM,
                                           castViewModel: castVM,
                                           videosViewModel: videoVM)
        return viewModel
    }
    
    private func createImageCollectionModel(imageURLs: [URL]) -> SectionImageCollectionViewModel {
        let imagesViewModel = SectionImageCollectionViewModel(title: R.string.localizable.images(), imageURLs: imageURLs)
            .observeAction { [weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .openDetails:
                    self.output?.imageGallerySeeAll()
                case .selectItem(let index):
                    self.output?.imageGallerySelectItem(atIndex: index)
                }
        }
        return imagesViewModel
    }
    
    private func createCastCollectionModel(movieWall: MovieWall) -> CastCollectionViewModel {
        let casts = movieWall.cast?.compactMap {
            CastCellViewModel(character: $0.character, name: $0.name)
            } ?? []
        let castImagesURLs = movieWall.cast?.compactMap { $0.profilePath?.url(size: EBackdropSize.w300)} ?? []
        let castViewModel = CastCollectionViewModel(title: R.string.localizable.cast(),
                                                    imageURLs: castImagesURLs,
                                                    casts: casts)
            .observeAction { [weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .openDetails:
                    self.output?.castsSeeAll()
                case .selectItem(let index):
                    self.output?.castsSelectItem(atIndex: index)
                }
        }
        return castViewModel
    }
    
    private func createVideoCollectionModel(movieWall: MovieWall) -> SectionImageCollectionViewModel {
        let videos = movieWall.videos?.results?.compactMap { URL(videoId: $0.videoId,
                                                                 quality: .high) } ?? []
        let videosViewModel = SectionImageCollectionViewModel(title: R.string.localizable.video(),
                                                              imageURLs: videos)
            .observeAction { [weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .openDetails:
                    self.output?.videoSeeAll()
                case .selectItem(let index):
                    self.output?.videoSelectItem(atIndex: index)
                }
        }
        return videosViewModel
    }
    
    private func createProductionStatusModel(movieWall: MovieWall) -> ProductionCellViewModel? {
        var productionStatusViewModel: ProductionCellViewModel?
        let releaseDate = Date(fromString: movieWall.movie?.releaseDate ?? "",
                               format: .isoDate)
        if let date = releaseDate, date.timeIntervalSince1970 > Date().timeIntervalSince1970 {
            productionStatusViewModel = ProductionCellViewModel(title: R.string.localizable.productionStatus(),
                                                                value: movieWall.movie?.status ?? "")
                .observeAction({ [weak self] (action) in
                    guard let self = self else { return }
                    switch action {
                    case .setupNotification:
                        self.output?.toggleNotification()
                    }
                })
        }
        return productionStatusViewModel
    }
    
    private func createHeaderSliderViewModel(imageURLs: [URL]) -> ImageCollectionViewModel {
        let headerSliderViewModel = ImageCollectionViewModel(imageURLs: imageURLs)
        return headerSliderViewModel
    }
    
    private func createMediaOverviewViewModel(movieWall: MovieWall) -> MediaOverviewViewModel {
        let mediaOverviewViewModel = MediaOverviewViewModel(text: movieWall.movie?.overview ?? "",
                                                            posterURL: movieWall.movie?.posterPath?.url(size: EPosterSize.w342),
                                                            actionTitle: R.string.localizable.addWatchList())
            .observeAction { [weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .openDetails:
                    self.output?.overviewSeeAll()
                case .watchlist:
                    self.output?.toggleWatchlist()
                }
        }
        return mediaOverviewViewModel
    }
    
    private func crateMediaTitleViewModel(movieWall: MovieWall) -> MediaTitleViewModel {
        let lines = [movieWall.movie?.description,
                     movieWall.movie?.genreList].compactMap { $0 }
        let mediaTitleViewModel = MediaTitleViewModel(title: movieWall.movie?.title ?? "",
                                                      lines: lines)
        return mediaTitleViewModel
    }
    
}
