//
//  ServiceErrors.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/23.
//

import Foundation

enum APIError: String, Error {
    case internalError
    case serverError
    case parsingError
}

enum CoreDataError: String, Error {
    case deleteError
    case saveError
    case fetchError
}

enum Method {
    case GET
    case POST
}
