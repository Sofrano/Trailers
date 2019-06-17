//
//  TextListTextListViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol TextListViewInput: class {

    func setupInitialState()
    func update(with viewModel: TextListViewModel)
    
}
