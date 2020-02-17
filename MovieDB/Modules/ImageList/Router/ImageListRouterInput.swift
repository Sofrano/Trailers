//
//  ImageListImageListRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol ImageListRouterInput: AlertRoutable, LoadingRoutable, PresentRoutable {
    
    func presentSlider(imageURLs: [URL], scrollToIndex index: Int)
}
