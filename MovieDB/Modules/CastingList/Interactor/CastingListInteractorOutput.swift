//
//  CastingListCastingListInteractorOutput.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 08/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation

protocol CastingListInteractorOutput: class {

    func onError(_ error: Error?)
    func onComplete()
    func onFetchedCredits(_ credits: DTOCredits)
}
