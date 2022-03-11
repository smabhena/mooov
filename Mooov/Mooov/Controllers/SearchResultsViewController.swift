//
//  SearchResultsViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    @IBOutlet private weak var searchLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var searchText: String = ""
    var results: SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if searchText == "" {
            searchText = "None"
        }

        let trimmedText: String = searchText.trimmingCharacters(in: .whitespaces)
        
        searchLabel.text = "Search results for '\(trimmedText)'"
        
        searchMovies(trimmedText)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func searchMovies(_ searchTitle: String) {
        let querySearch = URLQueryItem(name: "s", value: searchTitle)
        let queryResponse = URLQueryItem(name: "r", value: "json")
        let queryPage = URLQueryItem(name: "page", value: "1")
                
        var endpoint = Constants.endpoint
        endpoint.queryItems = [querySearch, queryResponse, queryPage]
                
        URLSession.shared.makeMovieRequest(url: endpoint.url, model: SearchResults.self) { [weak self] result in
        
            switch result {
            case .success(let data):
                self?.results = data
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.results?.search.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let movieTitle = self.results?.search[indexPath.row].title else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = movieTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMovieScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieInfoPage = segue.destination as? MovieInfoViewController {
                guard let index = tableView.indexPathForSelectedRow?.row else { return }
                guard let movie = results?.search[index] else { return }
                
                movieInfoPage.setMovieId(movie.imdbId)
                movieInfoPage.setMovieTitle(movie.title)
                movieInfoPage.setMovieImage(movie.poster)
        }
    }
}
