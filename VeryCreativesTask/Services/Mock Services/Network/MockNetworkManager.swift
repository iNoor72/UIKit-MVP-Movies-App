//
//  MockNetworkManager.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 18/04/2022.
//

import Foundation
import Alamofire

class MockNetworkManager: NetworkService {

    func fetchMovies<T:Decodable>(page: Int, type: MovieType, completion: @escaping (T?, Error?) -> ()) {
        if page == 1 {
            let data = MovieResponse()
            completion(data as? T, nil)
        } else {
            let error = NSError()
            completion(nil, error)
        }
    }
}
