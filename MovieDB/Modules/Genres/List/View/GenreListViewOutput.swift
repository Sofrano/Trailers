//
//  GenreListGenreListViewOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol GenreListViewOutput {
    func openMedia(_ media: DTOMovie)
    func viewIsReady()
}
