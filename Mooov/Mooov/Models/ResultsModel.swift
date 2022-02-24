//
//  ResultsModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Codable {
    let search: [Movie?]
    let totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
}
