//
//  Alertable.swift
//  KTK
//
//  Created by Dmitriy Safarov on 22/02/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

// Access to the functions of displaying alerts in the router

protocol AlertRoutable: Routable {
    
}

extension AlertRoutable {
    
    func showAlert(withMessage message: String, title: String? = nil, closeHandler: (() -> Void)? = nil) {
        guard let transitionHandler = transitionHandler as? UIViewController else {
            debugPrint("Transition handler should be UIViewController.")
            return
        }
        transitionHandler.showAlert(withMessage: message, title: title, closeHandler: closeHandler)
    }
}
