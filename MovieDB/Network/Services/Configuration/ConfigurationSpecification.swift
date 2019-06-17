//
//  ConfigurationConfigurationSpecification.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 30/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum ConfigurationSpecification {
    case getAPIConfiguration
    case getLanguages
}

extension ConfigurationSpecification: TargetType {
    
    var baseURL: URL {
        let url = (Bundle.init(for: AppDelegate.self).infoDictionary?["API_URL"] as? String) ?? ""
        return URL(string: "\(url)/configuration")!
    }
    
    var path: String {
        switch self {
        case .getAPIConfiguration:
            return ""
        case .getLanguages:
            return "languages"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAPIConfiguration, .getLanguages:
            return .get
        }
    }
    
    var sampleData: Data {
        fatalError("sampleData has not been implemented")
    }
    
    var task: Task {
        switch self {
        case .getAPIConfiguration, .getLanguages:
            return .requestPlain
        }
    }

    var headers: [ String: String ]? {
        return ["Content-type": "application/json"]
    }
    
}
