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
    
    private var id: String?
    private var movieTitle: String?
    private var image: String?
    
    private lazy var viewModel = MovieInfoViewModel(repository: MovieRepository() ,
                                                    delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = id {
            viewModel.fetchMovie(id)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movieTitle = movieTitle, let image = image {
            viewModel.isMovieSaved(movieTitle, image)
        }
    }
    
    @IBAction private func tappedAddButton() {
        viewModel.createMovieItem(movieTitle, image)
    }
    
    func setMovieId(_ id: String) {
        self.id = id
    }
    
    func setMovieTitle(_ title: String) {
        self.movieTitle = title
    }
    
    func setMovieImage(_ image: String) {
        self.image = image
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
    
    func loadContent(data: MovieInfo) {
        self.loadImageIntoImageView(data.poster, self.imageView)
        self.titleLabel.text = data.title
        self.genreLabel.text = data.genre
        self.runtimeLabel.text = data.runtime
        self.ratingLabel.text = data.imdbRating
        self.plotLabel.text = data.plot
    }
}
