//
//  MovieInfoViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/02.
//

import UIKit

class MovieInfoViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var plotLabel: UITextView!
    @IBOutlet private weak var savedMovieButton: UIButton!
    
    private lazy var viewModel = MovieInfoViewModel(movieRepository: MovieRepository(),
                                                    coreDataRepository: CoreDataRepository(),
                                                    delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.isMovieSaved()
    }
    
    @IBAction private func tappedAddButton() {
        viewModel.createMovie()
    }
    
    func set(_ movie: Movie) {
        viewModel.setMovie(movie)
    }
}

extension MovieInfoViewController: MovieInfoViewModelDelegate {
    func showError(error: String) {
        self.displayAlert(title: "Failed to fetch movies",
                          message: error,
                          buttonTitle: "Ok")
    }
    
    func disableButton() {
        self.savedMovieButton.disableButton("Saved")
    }
    
    func loadContent() {
        guard let data = viewModel.movieData else { return }
        
        self.loadImageIntoImageView(data.poster, self.imageView)
        self.titleLabel.text = data.title
        self.genreLabel.text = data.genre
        self.runtimeLabel.text = data.runtime
        self.ratingLabel.text = data.imdbRating
        self.plotLabel.text = data.plot
    }
}
