//
//  CastingListViewModelCreator.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/02/2020.
//  Copyright © 2020 SimpleCode. All rights reserved.
//

import Foundation

protocol CastingListViewModelCreator {
    /// Create casting list view model
    ///
    /// - parameter casts: List of casts
    /// - returns: ViewModel for CastList, with list of cell viewModels
    func createViewModel(with casts: [DTOCast]) -> CastingListViewModel
}

class CastingListViewModelDefault: CastingListViewModelCreator {
    
    func createViewModel(with casts: [DTOCast]) -> CastingListViewModel {
        let viewModel = CastingListViewModel()
        casts.forEach { (cast) in
            let url = cast.profilePath?.url(size: EBackdropSize.w300)
            let castViewModel = CastCellViewModel(character: cast.character,
                                                  name: cast.name,
                                                  imageURL: url)
            viewModel.castViewModels.append(castViewModel)
        }
        return viewModel
    }
    
}
