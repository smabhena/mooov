//
//  MovieInfoViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/02.
//

import UIKit

class MovieInfoViewController: UIViewController {
    var movieTitle: String?
    var movieId: String?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var moviePlot: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieId = movieId {
            getMovie(movieId)
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
                self?.loadImageIntoImageView(data.poster)
                self?.movieTitleLabel.text = data.title
                self?.movieGenre.text = data.genre
                self?.movieRuntime.text = data.runtime
                self?.movieRating.text = data.imdbRating
                self?.moviePlot.text = data.plot
                
                print("Data: \(data)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadImageIntoImageView(_ imageURL: String) {
        let url = URL(string: imageURL)
        guard let url = url else { return }
        movieImage.load(url: url)
    }
}
