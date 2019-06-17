//
//  PagerCellConfiguration.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

class PagerCellConfiguration: ViewModelConfiguration {
    let width: CGFloat
    var transform: CGAffineTransform = CGAffineTransform(scaleX: 0.6, y: 0.75)
    var transformerType: FSPagerViewTransformerType = .linear
    var height: CGFloat = 380
    var slidingInterval: CGFloat?
    
    init(width: CGFloat) {
        self.width = width
        super.init()
    }
    
}
