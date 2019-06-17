//
//  GenreListViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

class GenreListViewModel {
    let imageCollectionViewModel: ImageCollectionViewModel
    var movieShortDescriptionViewModel: MovieShortDescriptionCellViewModel?
    var textViewModel: TextCellViewModel?
    var currentPosterIndex: Int?
    var posterURL: URL? {
        return imageCollectionViewModel.URLs[safe: currentPosterIndex ?? 0]
    }
    init(imageCollectionViewModel: ImageCollectionViewModel) {
        self.imageCollectionViewModel = imageCollectionViewModel
    }
    
    
}

