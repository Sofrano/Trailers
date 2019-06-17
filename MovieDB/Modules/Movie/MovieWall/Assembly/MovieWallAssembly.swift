//
//  MovieWallMovieWallAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class MovieWallAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(MovieWallInteractor.self) { (_, presenter: MovieWallPresenter) in
            let interactor = MovieWallInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(MovieWallRouter.self) { (_, viewController: MovieWallViewController) in
            let router = MovieWallRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(MovieWallPresenter.self) { (resolver, viewController: MovieWallViewController) in
            let presenter = MovieWallPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(MovieWallInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(MovieWallRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(MovieWallViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(MovieWallPresenter.self, argument: viewController)
        }
    }

}
