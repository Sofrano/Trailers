//
//  HorizontalCollectionViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

enum EHorizontalCollectionAction {
    case selectItem(index: Int)
    case openDetails
}

class SectionImageCollectionViewModel: URLCollectionViewModel<EHorizontalCollectionAction> {
    
    typealias ConfigurationType = HorizontalCollectionConfiguration
    
    let title: String
    
    init(title: String, imageURLs: [URL]) {
        self.title = title
        super.init(imageURLs)
    }
}

class CastCollectionViewModel: SectionImageCollectionViewModel {
    var casts: [CastCellViewModel] = []
    
    init(title: String, imageURLs: [URL], casts: [CastCellViewModel]) {
        super.init(title: title, imageURLs: imageURLs)
        self.casts = casts
    }
}

enum EImageCollectionAction {
    case selectItem(index: Int)
}

class ImageCollectionViewModel: URLCollectionViewModel<EImageCollectionAction> {
    
    init(imageURLs: [URL]) {
        super.init(imageURLs)
    }
    
}
