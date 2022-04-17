//
//  NetworkTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 17/04/2022.
//

@testable import VeryCreativesTask
import XCTest


class NetworkTests: XCTestCase {
    
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

        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_fetching_popular_movies_from_homePresenter() {
        let expectation = XCTestExpectation(description: "response")

        
        wait(for: [expectation], timeout: 1)
    }
}
