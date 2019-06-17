//
//  GenresPagerGenresPagerInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol GenresPagerInteractorOutput: class {

    func onError(_ error: Error?)
    func onComplete()
    func onFetchedGenres(_ genres: [DTOGenre])
}
