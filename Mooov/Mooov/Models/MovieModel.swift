//
//  MovieModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let title, year, imdbId, type, poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
