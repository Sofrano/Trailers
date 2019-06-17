//
//  CastCellViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

enum ECastCellAction {
    case click(rowIndex: Int)
}

class CastCellViewModel: BaseViewModel<ECastCellAction> {
    let character: String?
    let name: String?
    let imageURL: URL?
    
    init(character: String?, name: String?, imageURL: URL? = nil) {
        self.character = character
        self.name = name
        self.imageURL = imageURL
    }
}
