//
//  YTYTViewOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 15/05/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol YTViewOutput {

    /**
        @author Dmitriy Safarov
        Notify presenter that view is ready
    */
    func close()
    func viewIsReady()
}
