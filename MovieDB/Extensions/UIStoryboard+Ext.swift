//
//  R+Ext.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 13/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Rswift
import LightRoute

extension UIStoryboard {
    
    var factory: StoryboardFactory {
        return StoryboardFactory(storyboard: self)
    }
    
}
