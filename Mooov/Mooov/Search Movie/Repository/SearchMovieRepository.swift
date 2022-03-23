//
//  SearchMovieRepository.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/23.
//

import Foundation

typealias SearchMovieResult = (Result<SearchResults, APIError>) -> Void

protocol SearchMovieRepositoryType: AnyObject {
    func fetchSearchResults(_ searchTitle: String, completion: @escaping(SearchMovieResult))
}

class SearchMovieRepository: SearchMovieRepositoryType {
    func fetchSearchResults(_ searchTitle: String, completion: @escaping (SearchMovieResult)) {
        let querySearch = URLQueryItem(name: "s", value: searchTitle)
        let queryResponse = URLQueryItem(name: "r", value: "json")
        let queryPage = URLQueryItem(name: "page", value: "1")
        var endpoint = Constants.endpoint
        
        endpoint.queryItems = [querySearch, queryResponse, queryPage]
        
        request(endpoint: endpoint, method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: Endpoint, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {        
        var request = URLRequest(url: endpoint.url)
        
        request.httpMethod = "\(method)"
        request.setValue(Constants.apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(Constants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
                return
            }
            do {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.serverError))
                    }
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.failure(.parsingError))
                }
            }
        }
        dataTask.resume()
    }
}
