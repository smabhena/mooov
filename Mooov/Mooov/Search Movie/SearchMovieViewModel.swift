//
//  SearchMovieViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/23.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class SearchMovieViewModel {
    private var repository: SearchMovieRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var movieResults: SearchResults?
    
    init(repository: SearchMovieRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var searchCount: Int {
        return self.movieResults?.search.count ?? 0
    }
    
    var results: SearchResults? {
        return self.movieResults
    }
    
    func getMovieTitle(_ atIndex: Int) -> String? {
        return movieResults?.search[atIndex].title
    }
    
    func getMovieObject(_ atIndex: Int) -> Movie? {
        return movieResults?.search[atIndex]
    }
    
    func fetchSearchResults(_ searchTitle: String) {
        repository?.fetchSearchResults(searchTitle, completion: { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.movieResults = searchResults
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
