//
//  NetworkTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 17/04/2022.
//

@testable import VeryCreativesTask
import XCTest

//MARK: These tests are written to test the network itself, it's not something to be done and that's why we use mocks.

class NetworkTests: XCTestCase {
    
    var sut: NetworkService!
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
        
        sut.fetchData(url: .topRated(page: 1), expectedType: MovieResponse.self) { result in
            switch result {
            case .failure(_):
                XCTFail("The network returned an error.")
            case .success(_):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(moviesList?.count ?? -1 >= 0)
   
    }
    
    func test_fetching_popular_movies_from_network_manager() {
        let expectation = XCTestExpectation(description: "response")
        
        sut.fetchData(url: .popular(page: 1), expectedType: MovieResponse.self) { result in
            switch result {
            case .failure(_):
                XCTFail("The network returned an error.")
            case .success(_):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(moviesList?.count ?? -1 >= 0)
    }
}
