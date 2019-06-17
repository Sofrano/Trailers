//
//  ShortOverviewViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 17/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

public enum EMediaTitleActions {
    case click
}

class MediaTitleViewModel: BaseViewModel<EMediaTitleActions> {
    let title: String
    let lines: [String]
    
    init(title: String, lines: [String]) {
        self.title = title
        self.lines = lines
    }
}
