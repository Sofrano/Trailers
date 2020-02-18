//
//  VideoListVideoListInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol VideoListInteractorOutput: class, InteractorOutput {

    func onFetchedVideos(_ videos: [DTOVideo])
    
}
