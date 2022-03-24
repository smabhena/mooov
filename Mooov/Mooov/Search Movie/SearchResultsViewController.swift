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
    
    private var searchText: String = ""
    
    private lazy var viewModel = SearchMovieViewModel(repository: SearchMovieRepository(),
                                                      delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.fetchSearchResults(setSearchResultsText())
    }
    
    func setSearchResultsText() -> String {
        let trimmedText: String = searchText.trimmingCharacters(in: .whitespaces)
        searchLabel.text = "Search results for '\(trimmedText)'"
        return trimmedText
    }
    
    func setSearchText(_ searchText: String) {
        self.searchText = searchText
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let movieTitle = viewModel.movieTitle(indexPath.row) else {
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
                guard let movie = viewModel.movieObject(index) else { return }
                
                movieInfoPage.setMovieId(movie.imdbId)
                movieInfoPage.setMovieTitle(movie.title)
                movieInfoPage.setMovieImage(movie.poster)
        }
    }
}

extension SearchResultsViewController: ViewModelDelegate {
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        displayAlert(title: "Error",
                     message: error,
                     buttonTitle: "Ok")
    }
}
