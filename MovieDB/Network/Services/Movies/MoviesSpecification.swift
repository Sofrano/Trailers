//
//  MoviesMoviesSpecification.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum MoviesSpecification {
    case getMovieDetails(_ params: MovieDetailsParameters)
    case getImages(for: MovieID, languages: [ELanguage])
    case getVideos(for: MovieID, languages: [ELanguage])
    case getCredits(for: MovieID)
}

extension MoviesSpecification: TargetType {
    
    var baseURL: URL {
        let url = (Bundle.init(for: AppDelegate.self).infoDictionary?["API_URL"] as? String) ?? ""
        return URL(string: "\(url)/movie")!
    }
    
    var path: String {
        switch self {
        case .getMovieDetails(let params):
            return "\(params.movieId ?? 0)"
        case .getImages(let movieId, _):
            return "\(movieId)/images"
        case .getVideos(let movieId, _):
            return "\(movieId)/videos"
        case .getCredits(let movieId):
            return "\(movieId)/credits"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieDetails,
             .getVideos,
             .getCredits,
             .getImages:
            return .get
        }
    }
    
    var sampleData: Data {
        fatalError("sampleData has not been implemented")
    }
    
    var task: Task {
        switch self {
        case .getMovieDetails(let encodable):
            return .requestParameters(parameters: encodable.parameters, encoding: URLEncoding.default)
        case .getCredits:
            return .requestPlain
        case .getImages(_, let languages),
             .getVideos(_, let languages):
            let params = ["language": languages.map { $0.languageIdentifier }.joined(separator: ",")]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [ String: String ]? {
        return ["Content-type": "application/json"]
    }
    
}
