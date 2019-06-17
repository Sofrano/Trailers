//
//  IAlertRoutable.swift
//  KTK
//
//  Created by Dmitriy Safarov on 04/01/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import LightRoute
import MessageUI

protocol Routable {
    
    var transitionHandler: TransitionHandler! { get set }
    
}
