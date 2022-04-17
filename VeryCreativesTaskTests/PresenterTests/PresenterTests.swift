//
//  PresenterTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 17/04/2022.
//

import XCTest
@testable import VeryCreativesTask

class PresenterTests: XCTestCase {
    var sut: HomePresenterProtocol!
    
    override func setUp() {
        super.setUp()
        let homeVC = HomeViewController()
        sut = HomePresenter(DatabaseManager: CoreDataManager(modelName: Constants.CoreDataModelFile), homeView: homeVC)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetching_topRated_movies_from_homePresenter() {
        let expectation = XCTestExpectation(description: "response")
        sut.fetchTopRatedMovies(page: 1)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_fetching_popular_movies_from_homePresenter() {
        let expectation = XCTestExpectation(description: "response")
        
        sut.fetchPopularMovies(page: 1)
        XCTAssertTrue(sut.popularMoviesList?.results?.count ?? -1 >= 0)
        
        wait(for: [expectation], timeout: 1)
    }
    
}
