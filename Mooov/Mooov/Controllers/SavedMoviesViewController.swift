//
//  SavedMoviesViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/10.
//

import UIKit

class SavedMoviesViewController: UIViewController {
    @IBOutlet private weak var savedMoviesTableView: UITableView!
    
    private var movies: [MovieItem]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        savedMoviesTableView.delegate = self
        savedMoviesTableView.dataSource = self
        savedMoviesTableView.rowHeight = 150
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllSavedMovies()
    }
    
    func getAllSavedMovies() {
        do {
            movies = try Constants.viewContext?.fetch(MovieItem.fetchRequest())
            DispatchQueue.main.async {
                self.savedMoviesTableView.reloadData()
            }
            
        } catch let error as NSError {
            print("Failed to fetch: \(error), \(error.userInfo)")
        }
    }
    
    func deleteMovieItem(_ movieItem: MovieItem) {
        guard let context = Constants.viewContext else {
            return
        }
        
        context.delete(movieItem)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save: \(error), \(error.userInfo)")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        
        guard let movie = movies?[indexPath.row] else {
            return UITableViewCell()
        }
        
        guard let image = movie.image else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = movie.title
        
        self.loadImageIntoImageView(image, cell.imageView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            guard let movieItem = movies?[indexPath.row] else { return }
            deleteMovieItem(movieItem)
            movies?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

class MovieTableViewCell: UITableViewCell {

}
