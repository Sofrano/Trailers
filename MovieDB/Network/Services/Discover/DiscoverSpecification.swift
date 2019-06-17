//
//  DiscoverDiscoverSpecification.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 29/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum DiscoverSpecification {
    case getDiscoverMedia(_ params: DiscoverMediaParameters)
}

extension DiscoverSpecification: TargetType {
    
    var baseURL: URL {
        let url = (Bundle.init(for: AppDelegate.self).infoDictionary?["API_URL"] as? String) ?? ""
        return URL(string: "\(url)/discover")!
    }
    
    var path: String {
        switch self {
        case .getDiscoverMedia:
            return "movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDiscoverMedia:
            return .get
        }
    }
    
    var sampleData: Data {
        fatalError("sampleData has not been implemented")
    }
    
    var task: Task {
        switch self {
        case .getDiscoverMedia(let encodable):
            return .requestParameters(parameters: encodable.parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}
