//
//  GenreListRouter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import LightRoute

final class GenreListRouter {
    
    weak var transitionHandler: TransitionHandler!
    
}

extension GenreListRouter: GenreListRouterInput {
    
    func presentMovie(_ movie: DTOMovie) {
        try? push(storyboard: R.storyboard.movieWallView(),
                  moduleInput: MovieWallModuleInput.self)
            .then({ (input) -> Any? in
                input.configure(with: movie.id)
            })
    }
    
}
