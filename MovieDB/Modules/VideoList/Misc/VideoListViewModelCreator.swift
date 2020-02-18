//
//  VideoListViewModelCreator.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 18/02/2020.
//  Copyright © 2020 SimpleCode. All rights reserved.
//

import Foundation

protocol VideoListViewModelOutput: class {
    
    func selectVideo(_ video: DTOVideo)
    
}

protocol VideoListViewModelCreator {
    
    func createViewModel(_ videos: [DTOVideo]) -> VideoListViewModel
    
}

class VideoListDefaultViewModelCreator: VideoListViewModelCreator {
  
    weak var output: VideoListViewModelOutput?
    
    // MARK: - Constructor
    
    init(output: VideoListViewModelOutput) {
        self.output = output
    }
    
    // MARK: - Functions
    
    func createViewModel(_ videos: [DTOVideo]) -> VideoListViewModel {
        let viewModel = VideoListViewModel()
        videos.forEach { (video) in
            let playerViewModel = YTPlayerCellViewModel(videoId: video.videoId,
                                                  name: video.name ?? "")
                .observeAction({ [weak self] (action) in
                    guard let self = self else { return }
                    switch action {
                    case .click:
                        self.output?.selectVideo(video)
                    }
                })
            viewModel.listViewModel.append(playerViewModel)
        }
        return viewModel
    }
    
}
