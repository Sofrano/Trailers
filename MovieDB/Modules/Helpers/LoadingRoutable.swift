//
//  Loadable.swift
//  KTK
//
//  Created by Dmitriy Safarov on 22/02/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import LightRoute
import SVProgressHUD

// Аccess to the display function of the load indicator in the router

protocol LoadingRoutable: Routable {
    
}

extension LoadingRoutable {
    
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
}
