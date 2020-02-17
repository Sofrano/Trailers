//
//  ImageListImageListRouter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import LightRoute
import PhotoSlider

final class ImageListRouter {

    weak var transitionHandler: TransitionHandler!

}

extension ImageListRouter: ImageListRouterInput {

    func presentSlider(imageURLs: [URL], scrollToIndex index: Int) {
        let slider = PhotoSlider.ViewController(imageURLs: imageURLs)
        slider.currentPage = index
        present(slider)
    }
    
}
