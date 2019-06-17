//
//  UIViewController+Ext.swift
//  BIGroup
//
//  Created by Dmitriy Safarov on 27/11/2018.
//  Copyright © 2018 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
    Hide keyboard when tapped around
    */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /**
    Display menu item on naviagtion panel
    */
    func displayMenuBarItem() {
        guard (self.navigationController?.viewControllers.count ?? 0) < 2 else { return }
    }
    
}
