//
//  VideoListVideoListRouter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import LightRoute

final class VideoListRouter {

    weak var transitionHandler: TransitionHandler!

}

extension VideoListRouter: VideoListRouterInput {

    func openVideo(_ video: DTOVideo) {
        try? push(storyboard: R.storyboard.ytView(),
                  moduleInput: YTModuleInput.self)
            .then({ (moduleInput) -> Any? in
                moduleInput.configure(with: video.key ?? "")
            })
        
    }
    
}
