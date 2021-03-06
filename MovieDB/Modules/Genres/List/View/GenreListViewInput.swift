//
//  GenreListViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol GenreListViewInput: class {
    
    func setupInitialState()
    func update(with viewModel: GenreListViewModel)
    
}
