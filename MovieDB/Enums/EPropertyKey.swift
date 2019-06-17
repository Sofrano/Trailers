//
//  EPropertyKey.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  API TheMovieDB enums
//  Used as parameters to get additional data in some APIs.

import Foundation

public enum EPropertyKey: String, Decodable, CaseIterable {
    case adult
    case airDate = "air_date"
    case alsoKnownAs = "also_known_as"
    case alternativeTitles = "alternative_titles"
    case biography
    case birthday
    case budget
    case cast
    case certifications
    case characterNames = "character_names"
    case createdBy = "created_by"
    case crew
    case deathDay = "deathday"
    case episode
    case episodeNumber = "episode_number"
    case episodeRunTime = "episode_run_time"
    case freebaseId = "freebase_id"
    case freebaseMid = "freebase_mid"
    case genres
    case guestStars = "guest_stars"
    case homepage
    case images
    case imdbId = "imdb_id"
    case languages
    case name
    case network
    case originCountry = "origin_country"
    case originalName = "original_name"
    case originalTitle = "original_title"
    case overview
    case parts
    case placeOfBirth = "place_of_birth"
    case plotKeywords = "plot_keywords"
    case productionCode = "production_code"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case releases
    case revenue
    case runtime
    case season
    case seasonNumber = "season_number"
    case seasonRegular = "season_regular"
    case spokenLanguages = "spoken_languages"
    case status
    case tagline
    case title
    case translations
    case tvdbId = "tvdb_id"
    case tvrageId = "tvrage_id"
    case type
    case video
    case videos
}
