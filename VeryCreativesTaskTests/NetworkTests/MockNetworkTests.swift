//
//  MockNetworkTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 18/04/2022.
//

import XCTest
@testable import VeryCreativesTask

class MockNetworkTests: XCTestCase {
    var sut: NetworkService!

    override func setUp() {
        super.setUp()
        sut = MockNetworkManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_mocking_call_with_page1() {
        let expectation = XCTestExpectation(description: "response")
        
        sut.fetchMovies(page: 1, type: .topRated) { (data: MovieResponse?, error:Error?) in
            if error != nil {
                XCTFail("You data couldn't be fetched due to an error")
            }
            
            if data != nil  {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_mocking_call_with_page2() {
        //I reveresed when expectation is fulfilled because we're expecting an error to be sent here
        let expectation = XCTestExpectation(description: "response")
        
        sut.fetchMovies(page: 2, type: .topRated) { (data: MovieResponse?, error:Error?) in
            if error != nil {
                expectation.fulfill()
            }
            
            if data != nil  {
                XCTFail("There was data back, test fails.")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }

}
