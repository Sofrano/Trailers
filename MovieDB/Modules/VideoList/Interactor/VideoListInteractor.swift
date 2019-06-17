//
//  VideoListVideoListInteractor.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 05/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
import PromiseKit

class VideoListInteractor: VideoListInteractorInput {
    
    weak var output: VideoListInteractorOutput?
    let service = MoviesNetworkService()
    
    func fetchVideos(for movieId: MovieID) {
        var promises = [self.service.getVideos(for: movieId, languages: [.application])]
        /* API does not allow specifying multiple languages.
           Most of the content is in English. We request data for the language
           selected by the user, as well as for the English language
         */
        if RSettings.language != ELanguage.en.languageIdentifier {
            promises.append(self.service.getVideos(for: movieId, languages: [.en]))
        }
        when(fulfilled: promises)
            .done { (videos) in
                let joinedVideos = videos.compactMap { $0.results }.flatMap { $0 }
                self.output?.onFetchedVideos(joinedVideos)
            }
            .catch { self.output?.onError($0) }
            .finally { self.output?.onComplete() }
    }
    
}
