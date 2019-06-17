//
//  NotificationManager.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
// I think that working with notifications should occur through the shell. It gives you more flexibility.

import Foundation

extension NSNotification.Name {
    static let changeLanguage = NSNotification.Name("changeLanguage")
}

class NotificationManager {
    
    static public func postNotification(_ notificationName: NSNotification.Name) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
    }
    
    static public func postNotification(_ notificationName: NSNotification.Name, withObject: Any?) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: notificationName, object: withObject)
        }
    }
    
    static public func observeNotification(_ observer: Any,
                                             notificationName: NSNotification.Name,
                                             selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: notificationName, object: nil)
    }
    
}
