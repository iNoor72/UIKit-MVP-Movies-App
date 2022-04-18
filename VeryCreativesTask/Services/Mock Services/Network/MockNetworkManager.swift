//
//  MockNetworkManager.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 18/04/2022.
//

import Foundation
import Alamofire

class MockNetworkManager: NetworkService {
    static let shared = MockNetworkManager()
    private init() {}
    
    var action : (()-> Void)?
    var error: Error?
    
    func fetchData<T: Decodable>(url: NetworkRouter, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        let data = MovieResponse(results: [MovieData](repeating: MovieData(),count: 2), totalPages: 1, page: 1)
        action = {
            if self.error != nil {
                self.error = NSError.init()
                completion(.failure(self.error!))
            } else {
                completion(.success(data as! T))
            }
        }
    }
}
