//
// NetworkService.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 18/04/2022.
//

import Foundation

protocol NetworkService {
    func fetchData<T:Decodable>(url: NetworkRouter, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ())
}

protocol NetworkRepositoryProtocol {
    associatedtype T 
    var fetchedMovies : [T] { get set }
}
