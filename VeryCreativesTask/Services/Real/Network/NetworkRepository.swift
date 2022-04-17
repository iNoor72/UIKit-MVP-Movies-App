//
//  NetworkRepository.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 16/04/2022.
//

import Foundation

class NetworkRepository {
    static let shared = NetworkRepository()
    var fetchedMovies = [MovieData]()
    private init() {}
    
    
}
