//
//  MovieInfoModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/02.
//

import Foundation

// MARK: - Movie Information

struct MovieInfo: Codable {
    let title, year, rated, released, runtime, genre, director, writer, actors, plot, language, country, awards, poster: String?
    let metascore, imdbRating, imdbVotes, imdbId, type, dvd, boxOffice, production, website, response: String?
    let rating: [Rating]?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbId = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case rating = "Ratings"
    }
}

struct Rating: Codable {
    let source: String?
    let value: String?
    
    enum CodingKeys:  String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
