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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = id {
            getMovie(id)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movieTitle = movieTitle {
            if let image = image {
                isMovieSaved(movieTitle, image)
            }
        }
    }
    
    @IBAction private func tappedAddButton() {
        createMovieItem(movieTitle, image)
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
    
    func createMovieItem(_ title: String?, _ image: String?) {
        guard let title = title else { return }
        guard let image = image else { return }
        guard let context = Constants.viewContext else { return }
        
        let newItem = MovieItem(context: context)
        newItem.title = title
        newItem.image = image
        
        do {
            try context.save()
            self.savedMovieButton.disableButton("Saved")
        } catch {
            self.displayAlert(title: "Failed to save movie",
                              message: "Try again",
                              buttonTitle: "Ok")
        }
    }
    
    func getMovie(_ movieID: String) {
        let queryID = URLQueryItem(name: "i", value: movieID)
        let queryResponse = URLQueryItem(name: "r", value: "json")
                
        var endpoint = Constants.endpoint
        endpoint.queryItems = [queryID, queryResponse]
                
        URLSession.shared.makeMovieRequest(url: endpoint.url, model: MovieInfo.self) { [weak self] result in
        
            switch result {
            case .success(let data):
                self?.loadImageIntoImageView(data.poster, self?.imageView)
                self?.titleLabel.text = data.title
                self?.genreLabel.text = data.genre
                self?.runtimeLabel.text = data.runtime
                self?.ratingLabel.text = data.imdbRating
                self?.plotLabel.text = data.plot
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func isMovieSaved(_ movieTitle: String, _ movieImage: String) {
        do {
            guard let movies = try Constants.viewContext?.fetch(MovieItem.fetchRequest()) else { return }
            
            for movie in movies where movie.title == movieTitle {
                self.savedMovieButton.disableButton("Saved")
                return
            }
        } catch {
            self.displayAlert(title: "Failed to fetch movies",
                              message: "Try again",
                              buttonTitle: "Ok")
        }
    }
}
