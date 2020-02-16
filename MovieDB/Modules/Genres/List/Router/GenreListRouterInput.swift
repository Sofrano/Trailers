//
//  GenreListRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol GenreListRouterInput: AlertRoutable, LoadingRoutable, PresentRoutable {

    /// Present a movie detail window
    func presentMovie(_ movie: DTOMovie)
    
}
