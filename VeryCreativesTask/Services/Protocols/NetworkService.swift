//
// NetworkService.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 18/04/2022.
//

import Foundation

protocol NetworkService {
    func fetchMovies<T:Decodable>(page: Int, type: MovieType, completion: @escaping (T?, Error?) -> ())
}

protocol NetworkRepositoryProtocol {
    associatedtype T 
    var fetchedMovies : [T] { get set }
}
