//
//  VideoListVideoListRouterInput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol VideoListRouterInput: AlertRoutable, LoadingRoutable, PresentRoutable {

    func presentVideo(_ video: DTOVideo)
    
}
