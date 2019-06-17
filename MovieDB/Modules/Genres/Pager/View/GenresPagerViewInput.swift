//
//  GenresPagerGenresPagerViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol GenresPagerViewInput: class {

    func setupInitialState()
    func update(with genres: [DTOGenre])
    
}
