//
//  ImageCellViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

enum EImageCellActions {
    case click(rowIndex: Int)
}

class ImageCellViewModel: BaseViewModel<EImageCellActions> {
    let imageURL: URL
    let aspectRatio: Double?
    
    init(imageURL: URL, aspectRatio: Double? = nil) {
        self.imageURL = imageURL
        self.aspectRatio = aspectRatio
    }
}
