//
//  MovieInfoViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/02.
//

import UIKit

class MovieInfoViewController: UIViewController {
    private var movieId: String?
    private var movieTitle: String?
    private var movieImage: String?
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieGenre: UILabel!
    @IBOutlet private weak var movieRuntime: UILabel!
    @IBOutlet private weak var movieRating: UILabel!
    @IBOutlet private weak var moviePlot: UITextView!
    @IBOutlet private weak var savedMovieButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieId = movieId {
            getMovie(movieId)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movieTitle = movieTitle {
            if let movieImage = movieImage {
                isMovieSaved(movieTitle, movieImage)
            }
        }
    }
    
    @IBAction private func tappedAddButton() {
        createMovieItem(movieTitle, movieImage)
    }
    
    func setMovieId(_ movieId: String) {
        self.movieId = movieId
    }
    
    func setMovieTitle(_ movieTitle: String) {
        self.movieTitle = movieTitle
    }
    
    func setMovieImage(_ movieImage: String) {
        self.movieImage = movieImage
    }
    
    func createMovieItem(_ movieTitle: String?, _ movieImage: String?) {
        guard let movieTitle = movieTitle else { return }
        guard let movieImage = movieImage else { return }
        guard let context = context else { return }
        
        let newItem = MovieItem(context: context)
        newItem.movieTitle = movieTitle
        newItem.movieImage = movieImage
        
        do {
            try context.save()
            self.savedMovieButton.disableButton("Saved")
        } catch {
            print("Failed to save")
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
                self?.loadImageIntoImageView(data.poster, self?.movieImageView)
                self?.movieTitleLabel.text = data.title
                self?.movieGenre.text = data.genre
                self?.movieRuntime.text = data.runtime
                self?.movieRating.text = data.imdbRating
                self?.moviePlot.text = data.plot
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func isMovieSaved(_ movieTitle: String, _ movieImage: String) {
        do {
            guard let movies = try context?.fetch(MovieItem.fetchRequest()) else { return }
            
            for movie in movies where movie.movieTitle == movieTitle {
                self.savedMovieButton.disableButton("Saved")
                return
            }
        } catch {
            print("Failed to get movies")
        }
    }
}
