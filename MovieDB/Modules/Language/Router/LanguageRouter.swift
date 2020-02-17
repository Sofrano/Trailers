//
//  EntryPointEntryPointRouter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import LightRoute

final class LanguageRouter {
    
    weak var transitionHandler: TransitionHandler!
    
}

extension LanguageRouter: LanguageRouterInput {
    
    func presentWelcome() {
        showAlert(withMessage: R.string.localizable.welcome(),
                  title: "Trailers",
                  closeHandler: nil)
    }
    
    func presentEntryPoint() {
        let viewController = R.storyboard.entryPointView.entryPointViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}
