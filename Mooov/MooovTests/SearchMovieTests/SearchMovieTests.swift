//
//  SearchMovieTests.swift
//  MooovTests
//
//  Created by Sinothando Mabhena on 2022/04/20.
//

import XCTest

class SearchMovieTests: XCTestCase {
    private var viewModel: SearchMovieViewModel!
    private var mockDelegate: MockDelegate!
    private var mockRepository: MockRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        mockDelegate = MockDelegate()
        viewModel = SearchMovieViewModel(repository: mockRepository, delegate: mockDelegate)
    }
    
    func testFetchSearchResultsSuccess() {
        viewModel.fetchSearchResults("t12341234")
        XCTAssert(mockDelegate.showReloadViewCalled)
        XCTAssertFalse(mockDelegate.showErrorCalled)
    }
    
    func testFetchSearchResultsFailure() {
        mockRepository.shouldFail = true
        viewModel.fetchSearchResults("t12341234")
        XCTAssert(mockDelegate.showErrorCalled)
        XCTAssertFalse(mockDelegate.showReloadViewCalled)
    }
    
    func testMovieTitle() {
        viewModel.fetchSearchResults("t12341234")
        guard let title = viewModel.movieTitle(0) else { return }
        XCTAssertEqual(title, "Batman")
    }
    
    func testSearchCount() {
        viewModel.fetchSearchResults("t12341234")
        XCTAssertEqual(viewModel.searchCount, 1)
    }
    
    func testSearchShouldBeZero() {
        XCTAssertEqual(viewModel.searchCount, 0)
    }
    
    func testMovieResults() {
        viewModel.fetchSearchResults("t12341234")
        XCTAssertNotNil(viewModel.results)
        XCTAssertEqual(viewModel.movieObject(0)?.title, "Batman")
    }
    
    func testMovieObject() {
        viewModel.fetchSearchResults("t12341234")
        XCTAssertNotNil(viewModel.movieObject(0))
        XCTAssertEqual(viewModel.movieObject(0)?.title, "Batman")
    }
    
    class MockDelegate: ViewModelDelegate {
        var showErrorCalled = false
        var showReloadViewCalled = false
        
        func show(error: String) {
            showErrorCalled = true
        }
        
        func reloadView() {
            showReloadViewCalled = true
        }
    }
    
    class MockRepository: MovieRepositoryType {
        var shouldFail = false

        let movie: MovieInfo = MovieInfo(title: "Batman",
                                         year: "2020",
                                         rated: "8/10",
                                         released: "2020",
                                         runtime: "127min",
                                         genre: "action",
                                         director: "Zac Snyder",
                                         writer: "Zac Synder",
                                         actors: "Some one",
                                         plot: "A plot",
                                         language: "English",
                                         country: "USA",
                                         awards: "None",
                                         poster: "Poster",
                                         metascore: "4/5",
                                         imdbRating: "9/10",
                                         imdbVotes: "352",
                                         imdbId: "t12341234",
                                         type: "Movie",
                                         dvd: "dvd",
                                         boxOffice: "boxoffice",
                                         production: "prod",
                                         website: "website",
                                         response: "response",
                                         rating: [Rating(
                                            source: "source",
                                            value: "value")])
        
        let result: SearchResults = SearchResults(search: [Movie(title: "Batman",
                                                                 year: "2022",
                                                                 imdbId: "9/10",
                                                                 type: "Movie",
                                                                 poster: "Poster")],
                                                  totalResults: "1",
                                                  response: "true")
        
        func fetchSearchResults(_ searchTitle: String, completion: @escaping (SearchMovieResult)) {
            if shouldFail {
                completion(.failure(.serverError))
            } else {
                completion(.success(result))
            }
            
        }
        
        func fetchMovie(_ movieID: String, completion: @escaping (FetchMovie)) {
            if shouldFail {
                completion(.failure(.serverError))
            } else {
                completion(.success(movie))
            }
        }
    }
}
