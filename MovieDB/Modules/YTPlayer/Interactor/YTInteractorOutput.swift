//
//  YTYTInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol YTInteractorOutput: class {

    func onError(_ error: Error?)
    func onComplete()
    
}
