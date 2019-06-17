//
//  GenresPagerGenresPagerAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class GenresPagerAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(GenresPagerInteractor.self) { (_, presenter: GenresPagerPresenter) in
            let interactor = GenresPagerInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(GenresPagerRouter.self) { (_, viewController: GenresPagerViewController) in
            let router = GenresPagerRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(GenresPagerPresenter.self) { (resolver, viewController: GenresPagerViewController) in
            let presenter = GenresPagerPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(GenresPagerInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(GenresPagerRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(GenresPagerViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(GenresPagerPresenter.self, argument: viewController)
        }
    }

}
