//
//  GenreListAssemblyContainer.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class GenreListAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(GenreListInteractor.self) { (_, presenter: GenreListPresenter) in
            let interactor = GenreListInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(GenreListRouter.self) { (_, viewController: GenreListViewController) in
            let router = GenreListRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(GenreListPresenter.self) { (resolver, viewController: GenreListViewController) in
            let presenter = GenreListPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(GenreListInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(GenreListRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(GenreListViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(GenreListPresenter.self, argument: viewController)
        }
    }

}
