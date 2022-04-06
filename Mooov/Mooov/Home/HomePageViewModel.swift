//
//  HomePageViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/04/04.
//

import Foundation

protocol HomePageViewModelDelegate: AnyObject {
    func showError(error: String)
    func reloadView()
}

class HomePageViewModel {
    private weak var delegate: HomePageViewModelDelegate?
    private var repository: MovieRepositoryType?
    private var fetchedMovies: [MovieInfo?]? = []
    
    init(delegate: HomePageViewModelDelegate,
         repository: MovieRepositoryType) {
        self.delegate = delegate
        self.repository = repository
        self.fetchMovies()
    }
    
    var count: Int {
        return fetchedMovies?.count ?? 0
    }
    
    var movies: [MovieInfo?]? {
        return fetchedMovies
    }
    
    func movie(atIndex: Int) -> MovieInfo? {
        return fetchedMovies?[atIndex]
    }
    
    func fetchMovies() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
                
        repository?.fetchMovie("tt1877830", completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.fetchedMovies?.append(result)
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        
        repository?.fetchMovie("tt10293406", completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.fetchedMovies?.append(result)
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        
        repository?.fetchMovie("tt1464335", completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.fetchedMovies?.append(result)
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        
        repository?.fetchMovie("tt10872600", completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.fetchedMovies?.append(result)
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main, execute: {
            self.delegate?.reloadView()
        })
    }
}
