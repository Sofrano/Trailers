//
//  AppInitializer.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 11/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

class AppInitializer {
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        var viewController: UIViewController!
        
        // Open the window with the choice of language, if the
        // language has not yet been set by the user
        if RSettings.language == nil {
            viewController = R.storyboard.languageView.languageViewController()
        } else {
            viewController = R.storyboard.entryPointView.entryPointViewController()
        }
        
        window.rootViewController = viewController
    }
    
    func setupNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.appColor.behance
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appColor.orange]
    }
    
}
