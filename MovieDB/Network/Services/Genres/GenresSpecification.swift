//
//  GenresGenresSpecification.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 29/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum GenresSpecification {
    case getGenres
}

extension GenresSpecification: TargetType {
    
    var baseURL: URL {
        let url = (Bundle.init(for: AppDelegate.self).infoDictionary?["API_URL"] as? String) ?? ""
        return URL(string: "\(url)/genre")!
    }
    
    var path: String {
        switch self {
        case .getGenres:
            return "movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGenres:
            return .get
        }
    }
    
    var sampleData: Data {
        fatalError("sampleData has not been implemented")
    }
    
    var task: Task {
        switch self {
        case .getGenres:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}
