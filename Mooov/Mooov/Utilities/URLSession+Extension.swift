//
//  URLSession+Extension.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import Foundation

extension URLSession {
    
    enum CustomError: Error {
        case invalidResponse
        case invalidRequest
        case invalidUrl
        case invalidData
    }
    
    func makeMovieRequest<Generic: Codable>(url: URL?,
                                            model: Generic.Type,
                                            completion: @escaping (Result<Generic, Error>) -> Void) {
        
        guard let endpointURL = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: endpointURL)
        
        request.httpMethod = "GET"
        request.setValue(Constants.apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(Constants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        let apiTask = self.dataTask(with: request) { data, _, error in
            
            guard let safeData = data else {
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(model, from: safeData)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        apiTask.resume()
    }
}
