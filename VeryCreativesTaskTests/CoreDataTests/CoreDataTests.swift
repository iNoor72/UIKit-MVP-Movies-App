//
//  CoreDataTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 17/04/2022.
//

@testable import VeryCreativesTask
import XCTest
import CoreData


class CoreDataTests: XCTestCase {
    
    var sut: CoreDataManager! //Or we can use DatabaseProtocol just to test the functions
    var mockMovie: MovieData!
    
    override func setUp() {
        super.setUp()
        sut = CoreDataManager(modelName: Constants.CoreDataModelFile)
        
        //Create a movie
        mockMovie = MovieData()
        mockMovie.id = 1
        mockMovie.title = "Noor"
        mockMovie.vote_average = 10.0
        mockMovie.movieState = .normal
        
        sut.save(movie: mockMovie)
    }
    
    override func tearDown() {
        sut.deleteAll()
        sut = nil
        super.tearDown()
    }
    
    func test_fetching_favorite_movies() {
        let movies = sut.fetch()
        let isMovieSaved = movies?.count == 1 ? true : false
        XCTAssertEqual(isMovieSaved, true)
    }
    
    func test_saving_favorite_movie() {
        let mockMovie2 = MovieData()
        mockMovie2.id = 2
        mockMovie2.title = "Noor2"
        mockMovie2.vote_average = 9.0
        mockMovie2.movieState = .favorited
        
        sut.save(movie: mockMovie2)
        
        let savedMovies = sut.fetch()
        let isMovieSaved = savedMovies?.contains { movieModel in
            if movieModel.id == Int32(mockMovie2.id ?? -1) {
                return true
            }
            
            return false
        }
        
        XCTAssertEqual(isMovieSaved, true)
        
    }
    
    func test_deleting_an_existing_favorite_movie() {
        sut.delete(movie: mockMovie)
        let movies = sut.fetch()
        XCTAssertEqual(movies?.count, 0)
    }
    
    func test_deleting_non_existing_movie() {
        let mockMovie2 = MovieData()
        mockMovie2.id = 2
        mockMovie2.title = "Noor2"
        mockMovie2.vote_average = 9.0
        mockMovie2.movieState = .favorited
        
        sut.delete(movie: mockMovie2)
        
        let movies = sut.fetch() //Should equal 1 since we only saved mockedMovie
        XCTAssertEqual(movies?.count, 1)
    }
    
    func test_deleting_all_movies() {
        sut.deleteAll()
        let movies = sut.fetch()
        
        XCTAssertEqual(movies?.count, 0)
    }
}
