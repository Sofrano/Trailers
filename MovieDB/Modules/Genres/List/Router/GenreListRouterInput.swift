//
//  GenreListGenreListRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol GenreListRouterInput: AlertRoutable, LoadingRoutable, PresentRoutable {

    func openMedia(_ media: DTOMovie)
    
}
