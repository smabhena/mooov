//
//  SaveMovieRepository.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/28.
//

import Foundation

typealias SavedMoviesResult = (Result<[MovieItem], CoreDataError>) -> Void
typealias DeleteMovie = (Result<Void, CoreDataError>) -> Void

class SaveMovieRepository {
    private var movies: [MovieItem]? = []
    
    func fetchSavedMovies(completion: @escaping (SavedMoviesResult)) {
        do {
            self.movies = try Constants.viewContext?.fetch(MovieItem.fetchRequest())
            guard let savedMovies = self.movies else { return }
            completion(.success(savedMovies))
            
        } catch {
            completion(.failure(.fetchError))
        }
    }
    
    func deleteMovie(movieItem: MovieItem, completion: @escaping (DeleteMovie)) {
        guard let context = Constants.viewContext else {
            completion(.failure(.deleteError))
            return
        }
        
        context.delete(movieItem)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.deleteError))
        }
    }
}
