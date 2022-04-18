//
//  NetworkRepository.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 16/04/2022.
//

import Foundation

class NetworkDataRepository: NetworkRepositoryProtocol {
    typealias T = MovieData
    
    static let shared = NetworkDataRepository()
    var fetchedMovies: [T]
    private init() {
        fetchedMovies = [MovieData]()
    }
    
    
}
