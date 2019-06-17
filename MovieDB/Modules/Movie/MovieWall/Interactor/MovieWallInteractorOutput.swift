//
//  MovieWallMovieWallInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol MovieWallInteractorOutput: class {

    func onError(_ error: Error?)
    func onComplete()
    /*
    func onFetchedMovie(_ movie: DTOMovie?, error: Error?)
    func onFetchedVideos(_ videos: DTOVideos?, error: Error?)
    func onFetchedImages(_ images: DTOImages?, error: Error?)
    func onFetchedCredits(_ credits: DTOCredits?, error: Error?)
    */
    func onFetchedWall(_ wall: MovieWall)
}
