//
//  EntryPointEntryPointAssembly.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class LanguageAssemblyContainer: Assembly {

    func assemble(container: Container) {

        container.register(LanguageInteractor.self) { (_, presenter: LanguagePresenter) in
            let interactor = LanguageInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(LanguageRouter.self) { (_, viewController: LanguageViewController) in
            let router = LanguageRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(LanguagePresenter.self) { (resolver, viewController: LanguageViewController) in
            let presenter = LanguagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(LanguageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(LanguageRouter.self, argument: viewController)
            return presenter
        }

        container.storyboardInitCompleted(LanguageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(LanguagePresenter.self, argument: viewController)
        }
    }

}
