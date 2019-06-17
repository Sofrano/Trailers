//
//  MovieWallMovieWallViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol MovieWallViewInput: class {

    func update(with viewModel: MovieWallViewModel)
    func setupInitialState()
    
}
