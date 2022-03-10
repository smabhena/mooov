//
//  MovieInfoViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/02.
//

import UIKit

class MovieInfoViewController: UIViewController {
    var movieId: String?
    var movieTitle: String?
    var movieImage: String?
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieGenre: UILabel!
    @IBOutlet private weak var movieRuntime: UILabel!
    @IBOutlet private weak var movieRating: UILabel!
    @IBOutlet private weak var moviePlot: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieId = movieId {
            getMovie(movieId)
        }
    }
    
    @IBAction private func tappedAddButton() {
        createMovieItem(movieTitle, movieImage)
    }
    
    func createMovieItem(_ movieTitle: String?, _ movieImage: String?) {
        guard let movieTitle = movieTitle else { return }
        guard let movieImage = movieImage else { return }
        guard let context = context else { return }
        
        let newItem = MovieItem(context: context)
        newItem.movieTitle = movieTitle
        newItem.movieImage = movieImage
        
        do {
            print("Saved")
            try context.save()
            self.displayAlert(title: "Movie: '\(movieTitle)' saved",
                              message: "Press OK to go back",
                              buttonTitle: "Ok")
        } catch {
            // Throw error
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
}
