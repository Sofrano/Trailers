//
//  NSError+Ext.swift
//  BIGroup
//
//  Created by Dmitriy Safarov on 09/11/2018.
//  Copyright © 2018 SimpleCode. All rights reserved.
//

import Foundation
import Moya

extension NSError {
    
    convenience init(_ mayaError: MoyaError?) {
        self.init(domain: "",
                  code: 0,
                  userInfo: [NSLocalizedDescriptionKey: mayaError?.errorDescription ?? "Unknown error" as Any])
    }
    
    convenience init?(_ string: String?) {
        self.init(domain: "",
                  code: 0,
                  userInfo: [NSLocalizedDescriptionKey: (string ?? "Unknown error") as Any])
    }
    
}
