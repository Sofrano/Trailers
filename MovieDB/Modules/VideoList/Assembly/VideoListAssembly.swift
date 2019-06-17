//
//  VideoListVideoListAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class VideoListAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(VideoListInteractor.self) { (_, presenter: VideoListPresenter) in
            let interactor = VideoListInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(VideoListRouter.self) { (_, viewController: VideoListViewController) in
            let router = VideoListRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(VideoListPresenter.self) { (resolver, viewController: VideoListViewController) in
            let presenter = VideoListPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(VideoListInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(VideoListRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(VideoListViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(VideoListPresenter.self, argument: viewController)
        }
    }

}
