//
//  ProductionCellViewModel.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 17/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

enum EProductionCellActions {
    case setupNotification
}

class ProductionCellViewModel: BaseViewModel<EProductionCellActions> {
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
