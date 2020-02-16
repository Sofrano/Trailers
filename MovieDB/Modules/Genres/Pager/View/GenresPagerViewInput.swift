//
//  GenresPagerGenresPagerViewInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import UIKit
protocol GenresPagerViewInput: class {

    func setupInitialState()
    
    /// Set pages for XLPagerTabStrip
    ///
    /// - parameter pages: list of any viewControllers to be shown in the pager.
    /// Requires XLPagerPage protocol support
    func update(withPages pages: [XLPagerPage])
    
}
