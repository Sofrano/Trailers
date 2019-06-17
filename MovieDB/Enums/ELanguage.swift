//
//  ELanguage.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  API TheMovieDB enums

import Foundation

public enum ELanguage {
    case en
    case null
    case ru
    case application
    
    var languageIdentifier: String {
        switch self {
        case .en:
            return "en"
        case .ru:
            return "ru"
        case .null:
            return "null"
        case .application:
            return RSettings.language ?? ""
        }
    }
}
