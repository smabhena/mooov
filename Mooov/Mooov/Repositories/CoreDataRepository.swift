//
//  SaveMovieRepository.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/28.
//

import Foundation

typealias SavedMoviesResult = (Result<[MovieItem], CoreDataError>) -> Void
typealias DeleteMovie = (Result<Void, CoreDataError>) -> Void
typealias CreateMovie = (Result<Void, CoreDataError>) -> Void

class CoreDataRepository {
    private var movies: [MovieItem]? = []
    
    func createMovieItem(movie: Movie?, completion: @escaping (CreateMovie)) {
        guard let movie = movie else {
            completion(.failure(.createError))
            return
        }
        
        guard let context = Constants.viewContext else {
            completion(.failure(.createError))
            return
            
        }
        
        let newItem = MovieItem(context: context)
        newItem.title = movie.title
        newItem.image = movie.poster
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.createError))
        }
        
    }
    
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
    
    func isMovieSaved(_ movie: Movie?, completion: @escaping (DeleteMovie)) {
        do {
            guard let movieObject = movie else { return }
            guard let movies = try Constants.viewContext?.fetch(MovieItem.fetchRequest()) else { return }
            for movie in movies where movie.title == movieObject.title {
                completion(.success(()))
                return
            }
        } catch {
            completion(.failure(.fetchError))
        }
        
    }
}
