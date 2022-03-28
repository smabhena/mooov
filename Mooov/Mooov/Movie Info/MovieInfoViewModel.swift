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
    func loadContent(data: MovieInfo)
}

class MovieInfoViewModel {
    private weak var delegate: MovieInfoViewModelDelegate?
    private var repository: MovieRepositoryType?
    
    init(repository: MovieRepository,delegate: MovieInfoViewModelDelegate) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func createMovieItem(_ title: String?, _ image: String?) {
        guard let title = title, let image = image, let context = Constants.viewContext else { return }

        let newItem = MovieItem(context: context)
        newItem.title = title
        newItem.image = image
        
        do {
            try context.save()
            self.delegate?.disableButton()
        } catch {
            self.delegate?.showError(error: "Try again")
        }
    }
    
    func isMovieSaved(_ movieTitle: String, _ movieImage: String) {
        do {
            guard let movies = try Constants.viewContext?.fetch(MovieItem.fetchRequest()) else { return }
            
            for movie in movies where movie.title == movieTitle {
                self.delegate?.disableButton()
                return
            }
        } catch {
            self.delegate?.showError(error: "Try again")
        }
    }
    
    func fetchMovie(_ movieID: String) {
        repository?.fetchMovie(movieID, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.delegate?.loadContent(data: result)
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
        })
    }
}
