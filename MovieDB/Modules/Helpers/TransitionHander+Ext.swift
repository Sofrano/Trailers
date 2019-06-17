//
//  TransitionHander+Ext.swift
//  KTK
//
//  Created by Dmitriy Safarov on 22/02/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import LightRoute

extension TransitionHandler where Self: UIViewController {
    
    func showAlert(withMessage message: String, title: String? = nil, closeHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            closeHandler?()
        })
        
        present(alert, animated: true, completion: nil)
    }
    
}
