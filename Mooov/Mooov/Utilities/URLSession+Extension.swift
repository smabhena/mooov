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
    
    func makeSearchRequest<Generic: Codable>(url: URL?,
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
            
            // Ensures that the data recieved is safe to use
            guard let safeData = data else {
                
                // Confirms if there is an error else custom error we created
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                // Runs JSON deserialization from the safe data into the generic model we pass in
                let result = try JSONDecoder().decode(model, from: safeData)
                
                // Tells the code we are complete and return what we deserialization
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        apiTask.resume()
        
    }
}
