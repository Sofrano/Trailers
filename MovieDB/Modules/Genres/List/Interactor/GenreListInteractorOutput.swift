//
//  GenreListGenreListInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol GenreListInteractorOutput: class {

    func onError(_ error: Error?)
    func onComplete()
    func onFetchedDiscoverMedia(_ discoverMedia: DTODiscoverMedia)
}
