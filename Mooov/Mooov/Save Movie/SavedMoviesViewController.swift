//
//  SavedMoviesViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/10.
//

import UIKit

class SavedMoviesViewController: UIViewController {
    @IBOutlet private weak var savedMoviesTableView: UITableView!
    
    private lazy var viewModel = SaveMovieViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        savedMoviesTableView.delegate = self
        savedMoviesTableView.dataSource = self
        savedMoviesTableView.rowHeight = 200
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getAllSavedMovies(delegate: self)
    }
}

extension SavedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SavedMovieTableViewCell else {
            return UITableViewCell()
        }

        guard let movie = viewModel.getMovie(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        guard let image = movie.image else {
            return UITableViewCell()
        }
        
        guard let title = movie.title else {
            return UITableViewCell()
        }
        
        cell.updateCellContent(image, title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            guard let movieItem = viewModel.getMovie(atIndex: indexPath.row) else { return }
            viewModel.deleteMovieItem(delegate: self, movieItem)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

extension SavedMoviesViewController: SaveMovieViewDelegate {
    func reloadView() {
        savedMoviesTableView.reloadData()
    }
    
    func show(error: String) {
        displayAlert(title: "Error occured",
                     message: error,
                     buttonTitle: "Ok")
    }
}
