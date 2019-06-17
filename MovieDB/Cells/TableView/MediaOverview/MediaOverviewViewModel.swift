//
//  ShortOverviewViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 17/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

enum EShortOverviewActions {
    case watchlist
    case openDetails
}

class MediaOverviewViewModel: BaseViewModel<EShortOverviewActions> {
    let text: String
    let posterUrl: URL?
    var actionTitle: String
    
    init(text: String, posterURL: URL?, actionTitle: String) {
        self.text = text 
        self.posterUrl = posterURL
        self.actionTitle = actionTitle
    }
    
}
