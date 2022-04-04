//
//  HomePageViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/04/04.
//

import Foundation

protocol HomePageViewModelDelegate: AnyObject {
    func showError(error: String)
    
}

class HomePageViewModel {
    private weak var delegate: HomePageViewModelDelegate?
    private var repository: MovieRepositoryType?
    private var newMovies: [String] = ["tt1877830","tt2463208"] // "The Batman", "The Adam Project"
    private var fetchedMovies: [MovieInfo?] = []
    
    init(delegate: HomePageViewModelDelegate,
         repository: MovieRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func newRelease() {
        for movie in newMovies {
            repository?.fetchMovie(movie, completion: { [weak self] result in
                switch result {
                case .success(let result):
                    self?.fetchedMovies.append(result)
                case .failure(let error):
                    self?.delegate?.showError(error: error.rawValue)
                }
            })
        }
    }
}
