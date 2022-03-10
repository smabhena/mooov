//
//  SavedMoviesViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/10.
//

import UIKit

class SavedMoviesViewController: UIViewController {
    @IBOutlet private weak var savedMoviesTableView: UITableView!
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var movies: [MovieItem]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllSavedMovies()
        savedMoviesTableView.delegate = self
        savedMoviesTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllSavedMovies()
    }
    
    func getAllSavedMovies() {
        do {
            movies = try context?.fetch(MovieItem.fetchRequest())
            DispatchQueue.main.async {
                self.savedMoviesTableView.reloadData()
            }
            
        } catch {
            // Throw error
        }
    }
    
    func deleteMovieItem(_ movieItem: MovieItem) {
        guard let context = context else {
            return
        }
        
        context.delete(movieItem)
        
        do {
            try context.save()
        } catch {
            // Throw error
        }
    }

}

extension SavedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = movies?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let movie = movies?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = movie.movieTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            guard let movieItem = movies?[indexPath.row] else {
                return
            }
            deleteMovieItem(movieItem)
            movies?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
