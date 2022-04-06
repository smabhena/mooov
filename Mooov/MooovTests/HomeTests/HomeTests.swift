//
//  HomeTests.swift
//  MooovTests
//
//  Created by Sinothando Mabhena on 2022/04/06.
//

import XCTest

class HomeTests: XCTestCase {
    private var viewModel: HomePageViewModel!
    private weak var mockDelegate: MockDelegate!
    private var mockRepository: MockRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        viewModel = HomePageViewModel(delegate: MockDelegate(), repository: mockRepository)
        
    }
    
    func testFetchMovie() {
        viewModel.fetchMovies()
        XCTAssertEqual(viewModel.movie(atIndex: 0)?.title, "Superman")
    }
    
    func testMoviesCount() {
        XCTAssertEqual(viewModel.count, 4)
    }
}
