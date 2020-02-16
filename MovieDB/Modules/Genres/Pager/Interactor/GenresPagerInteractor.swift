//
//  GenresPagerGenresPagerInteractor.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

class GenresPagerInteractor: GenresPagerInteractorInput {

    weak var output: GenresPagerInteractorOutput?
    
    func fetchGenres() {
        // The data is already in the configurator, which received information
        // about genres at the stage of loading the application
        self.output?.onFetchedGenres(ConfigurationManager.genres)
        output?.onComplete()
    }
    
}
