//
//  NetworkManager.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation
import Alamofire

class NetworkManager: NetworkService {
    static let shared = NetworkManager()
    
    private init() {}
    
    private func getURL(type: MovieType, page: Int) -> NetworkRouter {
        switch type {
        case .popular:
            return NetworkRouter.popular(page: page)
        case .topRated:
            return NetworkRouter.topRated(page: page)
        }
    }
    
    func fetchData<T:Decodable>(url: NetworkRouter, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(url).responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
