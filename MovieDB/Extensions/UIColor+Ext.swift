//
//  UIColor+Ext.swift
//  KTK
//
//  Created by Dmitriy Safarov on 07/01/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import UIKit

struct ApplicationColor {
    
    //https://www.materialui.co/flatuicolors
    
    var balticSea = UIColor(red: 61.0 / 255.0,
                            green: 61.0 / 255.0,
                            blue: 61.0 / 255.0,
                            alpha: 0.5)
    var peterRiver = UIColor(red: 52.0 / 255.0,
                             green: 152.0 / 255.0,
                             blue: 219.0 / 255.0,
                             alpha: 1.0)
    var pomegranate = UIColor(red: 192.0 / 255.0,
                         green: 57.0 / 255.0,
                         blue: 43.0 / 255.0,
                         alpha: 1.0)
    var orange = UIColor(red: 243.0 / 255.0,
                            green: 156.0 / 255.0,
                            blue: 18.0 / 255.0,
                            alpha: 1.0)
    var nephritis = UIColor(red: 39.0 / 255.0,
                          green: 174.0 / 255.0,
                          blue: 96.0 / 255.0,
                          alpha: 1.0)
    var behanceLight = UIColor(red: 53.0 / 255.0,
                          green: 59.0 / 255.0,
                          blue: 72.0 / 255.0,
                          alpha: 1.0)
    var behanceDark = UIColor(red: 47.0 / 255.0,
                           green: 54.0 / 255.0,
                           blue: 64.0 / 255.0,
                           alpha: 1.0)
    var behance = UIColor(red: 19.0 / 255.0,
                         green: 20.0 / 255.0,
                         blue: 24.0 / 255.0,
                         alpha: 1.0)
    var clouds = UIColor(red: 236.0 / 255.0,
                         green: 240.0 / 255.0,
                         blue: 241.0 / 255.0,
                         alpha: 1.0)
    var silver = UIColor(red: 189.0 / 255.0,
                         green: 195.0 / 255.0,
                         blue: 199.0 / 255.0,
                         alpha: 1.0)
    var midnightBlue = UIColor(red: 44.0 / 255.0,
                               green: 62.0 / 255.0,
                               blue: 80.0 / 255.0,
                               alpha: 1.0)
    
}

extension UIColor {
    
    static var appColor = ApplicationColor()
    
}
