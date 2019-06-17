//
//  Strint+Ext.swift
//  KTK
//
//  Created by Dmitriy Safarov on 17/01/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

extension String {

    func uppercaseFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
