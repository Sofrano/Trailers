//
//  URLCollectionViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 17/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

class URLCollectionViewModel<T>: BaseViewModel<T> {
    let URLs: [URL]
    init(_ urls: [URL]) {
        self.URLs = urls
    }
}
