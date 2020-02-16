//
//  GenresPagerGenresPagerRouter.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import LightRoute

final class GenresPagerRouter {

    weak var transitionHandler: TransitionHandler!

}

extension GenresPagerRouter: GenresPagerRouterInput {

    func createPages(with genres: [DTOGenre]) -> [XLPagerPage] {
        var pages: [XLPagerPage] = []
        genres.forEach { (genre) in
            try? transitionHandler
                .forStoryboard(factory: R.storyboard.genreListView().factory,
                               to: GenreListModuleInput.self)
                .to(preferred: TransitionStyle.split(style: .default))
                .apply(to: { (viewController) in
                    viewController.title = genre.name
                    guard let page = viewController as? XLPagerPage else { return }
                    pages.append(page)
                })
                .then({ (moduleInput) -> Any? in
                    moduleInput.configure(with: genre)
                })
        }
        return pages
    }
    
}
