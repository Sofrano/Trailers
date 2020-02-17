//
//  EntryPointEntryPointViewOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

protocol LanguageViewOutput {

    /**
        @author Dmitriy Safarov
        Notify presenter that view is ready
    */
    func search(_ query: String?)
    func viewIsReady()
}
