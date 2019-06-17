//
//  DTOMovie.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  TheMovieDB API Entity

import Foundation

public typealias ImagePath = String
public typealias PosterPath = ImagePath
public typealias BackdropPath = ImagePath
public typealias MovieID = Int

struct DTOMovie: Decodable {
    let adult: Bool?
    let backdropPath: BackdropPath?
    let budget: Int?
    let genres: [DTOGenre]?
    let homepage: String?
    let id: MovieID?
    let imdbId, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: PosterPath?
    let productionCompanies: [DTOProductionCompany]?
    let productionCountries: [DTOProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [DTOSpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let alternativeTitles: DTOAlternativeTitles?
    let translations: DTOTranslations?
    let videos: DTOVideos?
    let genreIds: [GenreID]?
    let images: DTOImages?
}

extension DTOMovie {
    
    var description: String {
        let date = Date(fromString: releaseDate ?? "", format: .isoDate)
        let year = date?.toString(format: .isoYear) ?? ""
        let runtimeHours = (runtime ?? 0) / 60
        let runtimeMinuts = (runtime ?? 0) - (runtimeHours * 60)
        let runtimes: [String?] = [
            runtimeHours == 0 ? nil : "\(runtimeHours)h",
            runtimeMinuts <= 0 ? nil : "\(runtimeMinuts)m"
        ]
        let runtimeString = runtimes.compactMap { $0 }.joined(separator: " ")
        return "\(year)    \(runtimeString)"
    }
    
    var genreList: String {
        return genres?.compactMap { $0.name }.joined(separator: ", ") ?? ""
    }
    
}

struct DTOTranslations: Decodable {
    let translations: [DTOTranslation]?
}

class DTOImages: Decodable {
    var backdrops: [DTOPoster]?
    var posters: [DTOPoster]?
}


struct DTOPoster: Decodable {
    let aspectRatio: Double?
    let filePath: ImagePath?
    let height: Int?
    let iso639_1: String?
    let voteAverage: Double?
    let voteCount, width: Int?
}

struct DTOTranslation: Decodable {
    let iso31661, iso6391, name, englishName: String?
    let data: DTODataClass?
}

struct DTOAlternativeTitles: Decodable {
    let titles: [DTOTitle]?
}

struct DTODataClass: Decodable {
    let title, overview: String?
    let homepage: String?
}

struct DTOTitle: Decodable {
    let iso31661, title, type: String?
}

struct DTOProductionCompany: Decodable {
    let id: Int?
    let logoPath, name, originCountry: String?
}

struct DTOProductionCountry: Decodable {
    let iso31661, name: String?
}

struct DTOSpokenLanguage: Decodable {
    let iso6391, name: String?
}

struct DTOVideos: Decodable {
    let results: [DTOVideo]?
}

struct DTOVideo: Decodable {
    let id, iso6391, iso31661, key: String?
    let name, site: String?
    let size: Int?
    let type: String?
}

extension DTOVideo {
    
    var videoId: YTVideoID {
        return key ?? ""
    }
    
}

enum DTOVideoType: String, Decodable {
    case clip
    case featurette
    case teaser
    case trailer
}

extension ImagePath {
    
    // Create a full URL to the poster image
    func url(size: String) -> URL? {
        let baseUrl = ConfigurationManager.image?.baseUrl ?? ""
        var fullUrl = "\(baseUrl)\(size)\\\(self)"
        fullUrl = "http://image.tmdb.org/t/p/\(size)\(self)"
        return URL(string: fullUrl)
    }
    
}

extension PosterPath {
    
    public func url(size: EPosterSize) -> URL? {
        return url(size: size.rawValue)
    }
    
}

extension BackdropPath {
    
    public func url(size: EBackdropSize) -> URL? {
        return url(size: size.rawValue)
    }
    
}
