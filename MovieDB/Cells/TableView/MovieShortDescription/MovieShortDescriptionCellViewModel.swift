//
//  MovieShortDescriptionCellViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

enum EShortDescriptionAction {
    case click
}

class MovieShortDescriptionCellViewModel: BaseViewModel<EShortDescriptionAction> {
    let title: String
    let year: String
    let genreNames: String
    let voteAverage: Double
    
    init(title: String, year: String, genreNames: String, voteAverage: Double) {
        self.title = title
        self.year = year
        self.genreNames = genreNames
        self.voteAverage = voteAverage
    }
}
