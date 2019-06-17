//
//  HorizontalCollectionConfiguration.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

class HorizontalCollectionConfiguration: ViewModelConfiguration {
    var configureCollectionCell: (UICollectionViewCell, Int) -> Void = { (_,_) in }
    var itemSize: CGSize = CGSize(width: 100, height: 150)
    var interitemItemSpacing: CGFloat = 10
    var registerCell: (class: Swift.AnyClass?, identifier: String)?
}
