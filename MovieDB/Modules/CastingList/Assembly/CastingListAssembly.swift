//
//  CastingListCastingListAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class CastingListAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(CastingListInteractor.self) { (_, presenter: CastingListPresenter) in
            let interactor = CastingListInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(CastingListRouter.self) { (_, viewController: CastingListViewController) in
            let router = CastingListRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(CastingListPresenter.self) { (resolver, viewController: CastingListViewController) in
            let presenter = CastingListPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(CastingListInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(CastingListRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(CastingListViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(CastingListPresenter.self, argument: viewController)
        }
    }

}
