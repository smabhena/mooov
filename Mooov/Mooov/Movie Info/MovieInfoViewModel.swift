//
//  MovieInfoViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/28.
//

import Foundation

protocol MovieInfoViewModelDelegate: AnyObject {
    func showError(error: String)
    func disableButton()
    func loadContent()
}

class MovieInfoViewModel {
    private weak var delegate: MovieInfoViewModelDelegate?
    private var movieRepository: MovieRepositoryType?
    private var coreDataRepository: CoreDataRepositoryType?
    private var data: MovieInfo?
    private var movie: Movie?
    
    init(movieRepository: MovieRepositoryType,
         coreDataRepository: CoreDataRepositoryType,
         delegate: MovieInfoViewModelDelegate) {
        self.delegate = delegate
        self.movieRepository = movieRepository
        self.coreDataRepository = coreDataRepository
    }
    
    var movieData: MovieInfo? {
        return data
    }
    
    func setMovie(_ movie: Movie) {
        self.movie = movie
    }
    
    func createMovie() {
        guard let movie = movie else { return }
        coreDataRepository?.createMovieItem(movie: movie, completion: { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.disableButton()
            case .failure:
                self?.delegate?.showError(error: "Failed to save movie")
            }
        })
    }
    
    func isMovieSaved() {   
        guard let movieObject = movie else { return }
        
        coreDataRepository?.isMovieSaved(movieObject, completion: { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.disableButton()
            case .failure:
                self?.delegate?.showError(error: "Failed to check if movie is saved")
            }
        })
        
    }
    
    func fetchMovie() {
        guard let movie = movie else { return }
        
        movieRepository?.fetchMovie(movie.imdbId, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.data = result
                self?.delegate?.loadContent()
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
        })
    }
}
