//
//  EntryPointEntryPointAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class EntryPointAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(EntryPointInteractor.self) { (_, presenter: EntryPointPresenter) in
            let interactor = EntryPointInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(EntryPointRouter.self) { (_, viewController: EntryPointViewController) in
            let router = EntryPointRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(EntryPointPresenter.self) { (resolver, viewController: EntryPointViewController) in
            let presenter = EntryPointPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(EntryPointInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(EntryPointRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(EntryPointViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(EntryPointPresenter.self, argument: viewController)
        }
    }

}
