//
//  NetworkTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 17/04/2022.
//

@testable import VeryCreativesTask
import XCTest


class NetworkTests: XCTestCase {
    
    var sut: NetworkManager!
    var moviesList: [MovieData]!
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager.shared
        moviesList = [MovieData]()
    }
    
    override func tearDown() {
        sut = nil
        moviesList = nil
        super.tearDown()
    }
    
    func test_fetching_topRated_movies_from_network_manager() {
        let expectation = XCTestExpectation(description: "response")
        //If device isn't connected to internet, the test should fail.
        if Reachability.isConnectedToNetwork() {
            sut.fetchMovies(page: 1, type: .topRated) {[weak self] (data: MovieResponse?, error: Error?) in
                if error != nil {
                    XCTFail("You data couldn't be fetched due to an error")
                }
                
                if data != nil  {
                    self?.moviesList = data?.results
                    expectation.fulfill()
                }
            }
            
            wait(for: [expectation], timeout: 1)
            XCTAssertTrue(moviesList?.count ?? -1 >= 0)
        } else {
            XCTFail("There is no internet conenction.")
        }
    }
    
    func test_fetching_popular_movies_from_network_manager() {
        let expectation = XCTestExpectation(description: "response")
        //If device isn't connected to internet, the test should fail.
        if Reachability.isConnectedToNetwork() {
            sut.fetchMovies(page: 1, type: .popular) {[weak self] (data: MovieResponse?, error: Error?) in
                if error != nil {
                    XCTFail("You data couldn't be fetched due to an error")
                }
                
                if data != nil  {
                    self?.moviesList = data?.results
                    expectation.fulfill()
                }
            }
            
            wait(for: [expectation], timeout: 1)
            XCTAssertTrue(moviesList?.count ?? -1 >= 0)
        } else {
            XCTFail("There is no internet conenction.")
        }
    }
}
