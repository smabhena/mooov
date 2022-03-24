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
    private var movies: [MovieItem]? = []
    
    init(delegate: SaveMovieViewDelegate) {
        self.delegate = delegate
    }
    
    var moviesCount: Int {
        return movies?.count ?? 0
    }
    
    func getMovies() -> [MovieItem]? {
        return movies
    }
    
    func getMovie(atIndex: Int) -> MovieItem? {
        return movies?[atIndex] 
    }
    
    func getAllSavedMovies(delegate: SaveMovieViewDelegate) {
        do {
            movies = try Constants.viewContext?.fetch(MovieItem.fetchRequest())
            DispatchQueue.main.async {
                delegate.reloadView()
            }
            
        } catch {
            delegate.show(error: "Try again")
        }
    }
    
    func deleteMovieItem(delegate: SaveMovieViewDelegate, _ movieItem: MovieItem) {
        guard let context = Constants.viewContext else {
            return
        }
        
        context.delete(movieItem)
        
        do {
            try context.save()
        } catch {
            delegate.show(error: "Try again")
        }
    }
}
