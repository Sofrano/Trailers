//
//  YTPlayerCellViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

public enum EYTPlayerActions {
    case click
}

class YTPlayerCellViewModel: BaseViewModel<EYTPlayerActions> {
    let videoId: YTVideoID
    let name: String
    
    init(videoId: YTVideoID, name: String) {
        self.videoId = videoId
        self.name = name
    }
}
