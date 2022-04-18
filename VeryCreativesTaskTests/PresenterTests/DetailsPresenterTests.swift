//
//  DetailsPresenterTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 18/04/2022.
//

import XCTest
@testable import VeryCreativesTask

class DetailsPresenterTests: XCTestCase {
    
    var sut: MovieDetailsPresenterProtocol!
    var mockedMovie: MovieData!
    var dbManager: DatabaseProtocol!
    override func setUp() {
        super.setUp()
        let vc = MovieDetailsViewController()
        dbManager = CoreDataManager(modelName: Constants.CoreDataModelFile)
        mockedMovie = MovieData()
        mockedMovie.id = 1
        mockedMovie.title = "Noor"
        mockedMovie.vote_average = 10.0
        mockedMovie.movieState = .normal
        
        sut = MovieDetailsPresenter(DatabaseManager: dbManager, movie: mockedMovie, detailsView: vc)
    }
    
    override func tearDown() {
        mockedMovie = nil
        sut = nil
        dbManager.deleteAll()
        super.tearDown()
    }
    
    func test_result_from_movie_state() {
        let isMovieFavorited = sut.isMovieFavorited(movie: mockedMovie)
        XCTAssertEqual(isMovieFavorited, false)
    }

}
