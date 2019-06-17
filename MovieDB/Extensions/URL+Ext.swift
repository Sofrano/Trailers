//
//  URL+Ext.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 19/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

extension URL {
    
    /**
     Init URL as youtube thumbnail link
    */
    init?(videoId: YTVideoID, quality: YTThumbnailQuailty) {
        self.init(string: "https://img.youtube.com/vi/\(videoId)/\(quality.rawValue)")
    }
    
}
