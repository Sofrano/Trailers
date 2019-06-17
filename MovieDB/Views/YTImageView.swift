//
//  YTImageView.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 04/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  Subclass UIImageView, which is able to load thumbnails from YouTube

import Foundation
import Kingfisher

typealias YTVideoID = String

class YTImageView: UIImageView {
    
    /**
     Load thumbnail of video from YouTube
     
     - Parameter videoId: youtube videoId e.g. X36Jz8hOXNg
    */
    public func loadThumbnail(for videoId: YTVideoID,
                              quality: YTThumbnailQuailty) {
        if let url = URL(videoId: videoId, quality: quality) {
            self.kf.setImage(with: url)
        }
    }
    
}
