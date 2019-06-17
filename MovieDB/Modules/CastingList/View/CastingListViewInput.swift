//
//  CastingListCastingListViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol CastingListViewInput: class {

    func setupInitialState()
    func update(with viewModel: CastingListViewModel)
    
}
