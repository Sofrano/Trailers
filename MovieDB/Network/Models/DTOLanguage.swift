//
//  DTOLanguage.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  TheMovieDB API Entity

import Foundation

struct DTOLanguage: Decodable {
    let iso6391, englishName, name: String?
}

extension DTOLanguage {
    
    var title: String {
        //Some names consist of question marks, ignore such names
        let processedName = (name ?? "").replacingOccurrences(of: "?", with: "")
        return (processedName.isEmpty
            ? englishName ?? ""
            : processedName).uppercaseFirstLetter()
    }
}
