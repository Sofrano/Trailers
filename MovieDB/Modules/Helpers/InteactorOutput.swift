//
//  InteractorStatusOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 13/02/2020.
//  Copyright © 2020 SimpleCode. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

// Default functions for the interactor
protocol InteractorOutput {
    func onError(_ error: Error?)
    func onComplete()
}

extension InteractorOutput {
    
    // By default, we show an error in the current window.
    // For more accurate error handling - you need to use your own
    // function implementation in the presenter
    func onError(_ error: Error?) {
        UIApplication.topViewController()?
            .showAlert(withMessage: error?.localizedDescription ?? R.string.localizable.errorUnknown())
    }
    
    // By default, we dismissing loading state
    func onComplete() {
        SVProgressHUD.dismiss()
    }
    
}
