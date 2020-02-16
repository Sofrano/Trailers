//
//  EntryPointEntryPointRouter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import LightRoute

final class EntryPointRouter {
    
    weak var transitionHandler: TransitionHandler!
    
}

extension EntryPointRouter: EntryPointRouterInput {
    
    func presentGenreList() {
        if let viewController = R.storyboard.genresPagerView.genresPagerViewController() {
            let navigationController = UINavigationController(rootViewController: viewController)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        }
    }
    
}
