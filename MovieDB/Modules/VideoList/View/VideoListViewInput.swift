//
//  VideoListVideoListViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol VideoListViewInput: class {

    func update(with viewModel: VideoListViewModel)
    func setupInitialState()
}
