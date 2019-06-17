//
//  APIErrorPlugin.swift
//  BIGroup
//
//  Created by Dmitriy Safarov on 04/11/2018.
//  Copyright © 2018 SimpleCode. All rights reserved.
//

import Foundation
import Moya
import Result

enum MovieDBError: Error {
    case server(error: DTOError)
}

extension MovieDBError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .server(let error):
            return error.statusMessage
        }
    }
    
}

class ErrorsProcessor: PluginType {
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case .success(let response):
            switch response.statusCode {
            case 200:
                return result
            default:
                let decoder = JSONDecoder.snakeCaseStrategy
                if let error = try? decoder.decode(DTOError.self, from: response.data) {
                    return Result(error: MoyaError.underlying(MovieDBError.server(error: error), response))
                }
                return Result(error: MoyaError.statusCode(response))
            }
        case .failure:
            return result
        }
    }

}
