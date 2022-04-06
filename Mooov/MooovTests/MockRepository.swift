//
//  MockRepository.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/04/06.
//

import Foundation

class MockRepository: MovieRepositoryType {
    let movie: MovieInfo = MovieInfo(title: "Superman", year: "2020", rated: "8/10", released: "2020", runtime: "127min", genre: "action", director: "Zac Snyder", writer: "Zac Synder", actors: "Some one", plot: "A plot", language: "English", country: "USA", awards: "None", poster: "Poster", metascore: "4/5", imdbRating: "9/10", imdbVotes: "352", imdbId: "t12341234", type: "Movie", dvd: "dvd", boxOffice: "boxoffice", production: "prod", website: "website", response: "response", rating: [Rating(source: "source", value: "value")])
    
    let result: SearchResults = SearchResults(search: [Movie(title: "Batman", year: "2022", imdbId: "9/10", type: "Movie", poster: "Poster")], totalResults: "1", response: "true")
    
    func fetchSearchResults(_ searchTitle: String, completion: @escaping (SearchMovieResult)) {
        completion(.success(result))
    }
    
    func fetchMovie(_ movieID: String, completion: @escaping (FetchMovie)) {
        completion(.success(movie))
    }
}
