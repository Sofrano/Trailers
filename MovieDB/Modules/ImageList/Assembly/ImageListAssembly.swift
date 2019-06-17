//
//  ImageListImageListAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class ImageListAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(ImageListInteractor.self) { (_, presenter: ImageListPresenter) in
            let interactor = ImageListInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(ImageListRouter.self) { (_, viewController: ImageListViewController) in
            let router = ImageListRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(ImageListPresenter.self) { (resolver, viewController: ImageListViewController) in
            let presenter = ImageListPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(ImageListInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(ImageListRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(ImageListViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(ImageListPresenter.self, argument: viewController)
        }
    }

}
