//
//  Collection+Ext.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 12/06/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
