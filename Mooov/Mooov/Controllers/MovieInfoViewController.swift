//
//  MovieInfoViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/02.
//

import UIKit

class MovieInfoViewController: UIViewController {
    var movieId: String?
    
    @IBOutlet private weak var movieImage: UIImageView!
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
    
    func getMovie(_ movieID: String) {
        let queryID = URLQueryItem(name: "i", value: movieID)
        let queryResponse = URLQueryItem(name: "r", value: "json")
                
        var endpoint = Constants.endpoint
        endpoint.queryItems = [queryID, queryResponse]
                
        URLSession.shared.makeMovieRequest(url: endpoint.url, model: MovieInfo.self) { [weak self] result in
        
            switch result {
            case .success(let data):
                self?.loadImageIntoImageView(data.poster, self?.movieImage)
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
}
