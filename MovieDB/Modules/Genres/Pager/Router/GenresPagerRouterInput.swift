//
//  GenresPagerGenresPagerRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

protocol GenresPagerRouterInput: AlertRoutable, LoadingRoutable {
    
    /// Creating pages for showing genres
    ///
    /// - parameter genres: list of genres
    /// - returns: list of viewControllers, supported XLPagerPage protocol
    func createPages(with genres: [DTOGenre]) -> [XLPagerPage]
    
}
