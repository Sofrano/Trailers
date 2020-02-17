//
//  ImageListViewModelCreator.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 17/02/2020.
//  Copyright © 2020 SimpleCode. All rights reserved.
//

import Foundation

protocol ImageListViewModelOutput: class {
    func imageClick(atIndex: Int)
}

protocol ImageListViewModelCreator {
    
    func createViewModel(_ posters: [DTOPoster]) -> ImageListViewModel
    
}

class ImageListDefaultViewModelCreator: ImageListViewModelCreator {
    
    weak var output: ImageListViewModelOutput?
    
    // MARK: - Constructor
    
    init(output: ImageListViewModelOutput) {
        self.output = output
    }
    
    // MARK: - Functions
    
    func createViewModel(_ posters: [DTOPoster]) -> ImageListViewModel {
        let viewModel = ImageListViewModel()
        posters.forEach { (poster) in
            if let url = poster.filePath?.url(size: EBackdropSize.original) {
                let imageViewModel = ImageCellViewModel(imageURL: url,
                                                        aspectRatio: poster.aspectRatio)
                    .observeAction({ [weak self] (action) in
                        guard let self = self else { return }
                        switch action {
                        case .click(let index):
                            self.output?.imageClick(atIndex: index)
                        }
                    })
                viewModel.imagesViewModel.append(imageViewModel)
            }
        }
        return viewModel
    }
    
}
