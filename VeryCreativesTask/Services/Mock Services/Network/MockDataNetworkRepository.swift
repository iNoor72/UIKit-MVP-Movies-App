//
//  MockNetworkRepository.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 18/04/2022.
//

import Foundation

class MockDataNetworkRepository: NetworkRepositoryProtocol {
    typealias T = MovieData
    
    static let shared = MockDataNetworkRepository()
    lazy var fetchedMovies: [MovieData] = {
        var mockedMovies = [MovieData]()
        for index in 0...3 {
            let movie = MovieData()
            movie.id = index
            movie.title = "Mock \(index)"
            movie.movieState = .normal
            movie.overview = "Mocked overview \(index)"
            movie.vote_average = 5.0
            movie.poster_path = ""
            movie.backdrop_path = ""
            mockedMovies.append(movie)
        }
        return mockedMovies
    }()
    
    private init() {}
}
