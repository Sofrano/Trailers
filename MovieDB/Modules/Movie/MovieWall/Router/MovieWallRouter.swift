//
//  MovieWallMovieWallRouter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import LightRoute
import PhotoSlider

final class MovieWallRouter {

    weak var transitionHandler: TransitionHandler!

}

extension MovieWallRouter: MovieWallRouterInput {
    
    func openOverview(_ overview: String, title: String) {
        try? push(storyboard: R.storyboard.textListView(),
                  moduleInput: TextListModuleInput.self)
            .apply(to: { (viewController) in
                viewController.title = title
            })
            .then({ (moduleInput) -> Any? in
                moduleInput.configure(with: [overview])
            })
    }
    
    func openVideo(_ video: DTOVideo) {
        try? push(storyboard: R.storyboard.ytView(),
                  moduleInput: YTModuleInput.self)
            .then({ (moduleInput) -> Any? in
                moduleInput.configure(with: video.key ?? "")
            })
    }
    
    func openImageGallery(with photos: [DTOPoster]) {
        try? push(storyboard: R.storyboard.imageListView(), moduleInput: ImageListModuleInput.self)
            .apply(to: { (viewController) in
                viewController.title = "Image Gallery"
            })
            .then({ (moduleInput) -> Any? in
                moduleInput.configure(with: photos)
            })
    }
    
    func openVideoGallery(for movieId: MovieID) {
        try? push(storyboard: R.storyboard.videoListView(),
                  moduleInput: VideoListModuleInput.self)
            .apply(to: { (viewController) in
                viewController.title = "Video Gallery"
            })
            .then({ (moduleInput) -> Any? in
                moduleInput.configure(with: movieId)
            })
    }
    
    func openCastGallery(for movieId: MovieID) {
        try? push(storyboard: R.storyboard.castingListView(), moduleInput: CastingListModuleInput.self)
            .then({ (moduleInput) -> Any? in
                moduleInput.configure(with: movieId)
            })
    }
    
    func openPhotoSlider(with images: [URL], currentPage: Int) {
        let slider = PhotoSlider.ViewController(imageURLs: images)
        slider.currentPage = currentPage
        self.present(slider, animated: true)
    }

}
