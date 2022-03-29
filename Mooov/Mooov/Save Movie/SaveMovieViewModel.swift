//
//  SaveMovieViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/24.
//

import Foundation

protocol SaveMovieViewDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class SaveMovieViewModel {
    private weak var delegate: SaveMovieViewDelegate?
    private var repository: SaveMovieRepository?
    private var movies: [MovieItem]? = []
    
    init(delegate: SaveMovieViewDelegate, repository: SaveMovieRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    var moviesCount: Int {
        return movies?.count ?? 0
    }
    
    var movieList: [MovieItem]? {
        return movies
    }
    
    func movie(atIndex: Int) -> MovieItem? {
        return movies?[atIndex] 
    }
    
    func allSavedMovies() {
        repository?.fetchSavedMovies(completion: { [weak self] movies in
            switch movies {
            case .success(let savedMovies):
                self?.movies = savedMovies
                DispatchQueue.main.async {
                    self?.delegate?.reloadView()
                }
            case .failure:
                self?.delegate?.show(error: "Failed to fetch movies")
            }
        })
    }
    
    func deleteMovieItem(_ movieItem: MovieItem, _ index: Int) {
        repository?.deleteMovie(movieItem: movieItem, completion: { [weak self] deleteMovie in
            switch deleteMovie {
            case .success:
                self?.movies?.remove(at: index)
            case .failure:
                self?.delegate?.show(error: "Failed to delete movie")
            }
            
        })
    }
}
