//
//  Endpoint.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import Foundation

struct Endpoint {
    var path: String = ""
    var queryItems: [URLQueryItem] = []
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "movie-database-imdb-alternative.p.rapidapi.com"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL Components: \(components)")
        }
        return url
    }
}
