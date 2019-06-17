//
//  Encodable+Ext.swift
//  KTK
//
//  Created by Dmitriy Safarov on 04/01/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

extension Encodable {
    
    var parameters: [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? encoder.encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] } ?? [:]
    }
    
}
