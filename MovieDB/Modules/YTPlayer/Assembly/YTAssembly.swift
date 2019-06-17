//
//  YTYTAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class YTAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(YTInteractor.self) { (_, presenter: YTPresenter) in
            let interactor = YTInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(YTRouter.self) { (_, viewController: YTViewController) in
            let router = YTRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(YTPresenter.self) { (resolver, viewController: YTViewController) in
            let presenter = YTPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(YTInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(YTRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(YTViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(YTPresenter.self, argument: viewController)
        }
    }

}
