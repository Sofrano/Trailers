//
//  TextListTextListAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class TextListAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(TextListInteractor.self) { (_, presenter: TextListPresenter) in
            let interactor = TextListInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(TextListRouter.self) { (_, viewController: TextListViewController) in
            let router = TextListRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(TextListPresenter.self) { (resolver, viewController: TextListViewController) in
            let presenter = TextListPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(TextListInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(TextListRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(TextListViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(TextListPresenter.self, argument: viewController)
        }
    }

}
