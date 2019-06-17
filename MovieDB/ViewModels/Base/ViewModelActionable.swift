//
//  ViewModelActionable.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 16/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

enum EmptyActions {}

class BaseViewModel<T> {
    var configuration: ViewModelConfiguration? = nil
    private var observeAction: (T) -> () = {_ in}
    public func invoke(action: T) {
        observeAction(action)
    }
    public func observeAction(_ handler: @escaping (_ action: T) -> ()) -> Self {
        observeAction = handler
        return self
    }
}
