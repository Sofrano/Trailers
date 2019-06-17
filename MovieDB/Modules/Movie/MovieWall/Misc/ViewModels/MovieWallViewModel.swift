//
//  MovieWallViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

class MovieWallViewModel {
    let headerSliderViewModel: ImageCollectionViewModel
    let mediaTitleViewModel: MediaTitleViewModel
    let productionStatusViewModel: ProductionCellViewModel?
    var mediaOverviewViewModel: MediaOverviewViewModel
    let imagesViewModel: SectionImageCollectionViewModel
    let castViewModel: CastCollectionViewModel
    let videosViewModel: SectionImageCollectionViewModel
    
    init(headerSliderViewModel: ImageCollectionViewModel,
         mediaTitleViewModel: MediaTitleViewModel,
         productionStatusViewModel: ProductionCellViewModel?,
         mediaOverviewViewModel: MediaOverviewViewModel,
         imagesViewModel: SectionImageCollectionViewModel,
         castViewModel: CastCollectionViewModel,
         videosViewModel: SectionImageCollectionViewModel) {
        self.headerSliderViewModel = headerSliderViewModel
        self.mediaTitleViewModel = mediaTitleViewModel
        self.imagesViewModel = imagesViewModel
        self.castViewModel = castViewModel
        self.videosViewModel = videosViewModel
        self.productionStatusViewModel = productionStatusViewModel
        self.mediaOverviewViewModel = mediaOverviewViewModel
    }
}
