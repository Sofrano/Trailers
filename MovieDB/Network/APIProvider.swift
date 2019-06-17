//
//  APIProvider.swift
//  BIGroup
//
//  Created by Dmitriy Safarov on 04/11/2018.
//  Copyright © 2018 SimpleCode. All rights reserved.
//

import Foundation
import Moya
import Result

class APIProvider<Target: TargetType> {
    
    public var provider: MoyaProvider<Target> {
            let endpointClosure = { (target: Target) -> Endpoint in
                let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
                return defaultEndpoint
            }
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 60
            configuration.timeoutIntervalForResource = 60
            configuration.httpAdditionalHeaders = Moya.Manager.defaultHTTPHeaders
            
            let manager = Moya.Manager(configuration: configuration)
            manager.startRequestsImmediately = false
            
            return MoyaProvider<Target>(endpointClosure: endpointClosure,
                                                     stubClosure: MoyaProvider.neverStub,
                                                     manager: manager,
                                                     plugins: [InterceptPlugin(),
                                                               ErrorsProcessor(),
                                                               NetworkLoggerPlugin(verbose: true)])
    }
}

struct InterceptPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let url = request.url?.absoluteString,
            var components = URLComponents(string: url) else {
            return request
        }
        components.queryItems = components.queryItems ?? []
        
        //Add a key to each request.
        let key = (Bundle.init(for: AppDelegate.self).infoDictionary?["API_KEY"] as? String) ?? ""
        components.queryItems?.append(URLQueryItem(name: "api_key", value: key))
        
        //If the locale is not specified, then replace it by default.
        if !(components.queryItems?.contains(where: { $0.name == "language" }) ?? false) {
            components.queryItems?.append(URLQueryItem(name: "language", value: RSettings.language ?? "en"))
        }
        var apiRequest = request
        apiRequest.url = try? components.asURL()
        return apiRequest
    }
    
}
