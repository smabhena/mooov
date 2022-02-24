//
//  ViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var results: SearchResults?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchMovies("Avengers Endgame")
    }
    
    func searchMovies(_ searchTitle: String) {
        
        let querySearch = URLQueryItem(name: "s", value: searchTitle)
        let queryResponse = URLQueryItem(name: "r", value: "json")
        let queryPage = URLQueryItem(name: "page", value: "1")
                
        // Create endpoint and add query items
        var endpoint = Constants.endpoint
        endpoint.queryItems = [querySearch, queryResponse, queryPage]
                
        // Asks the url session to make a call to our custom function
        URLSession.shared.makeSearchRequest(url: endpoint.url, model: SearchResults.self) { result in

            // Swift the state of the result
            switch result {
            case .success(let searchResults):
                
                print("Results: \(searchResults)")

            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.image = image
                            }
                        }
                    }
                }
    }
}
