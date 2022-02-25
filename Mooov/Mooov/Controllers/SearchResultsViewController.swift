//
//  SearchResultsViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchText: String = ""
    
    var results: SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if searchText == "" {
            searchText = "None"
        }

        searchLabel.text = "'\(searchText)'"
        
        searchMovies(searchText)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let res = self.results {
            print("Results: \(res)")
        }
    }
    
    func searchMovies(_ searchTitle: String) {
        
        let querySearch = URLQueryItem(name: "s", value: searchTitle)
        let queryResponse = URLQueryItem(name: "r", value: "json")
        let queryPage = URLQueryItem(name: "page", value: "1")
                
        var endpoint = Constants.endpoint
        endpoint.queryItems = [querySearch, queryResponse, queryPage]
                
        URLSession.shared.makeSearchRequest(url: endpoint.url, model: SearchResults.self) { [weak self] result in
        
            switch result {
            case .success(let data):
                self?.results = data
                print("Data: \(data)")
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.results?.search?.count {
            print("Count: \(count)")
            return count
        }
        print("Failed to get count")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let movieTitle = self.results?.search?[indexPath.row].title {
            cell.textLabel?.text = movieTitle
        }
        return cell
    }
}
