//
//  NetworkManager.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation
import Alamofire

class NetworkManager {
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
    
    func fetchMovies<T:Decodable>(page: Int, type: MovieType, completion: @escaping (T?, Error?) -> ()) {
        let url = getURL(type: type, page: page)
        
        AF.request(url).responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .failure(let error):
                print("There was a problem fetching data form API. Error: \(error)")
                completion(nil, error)
                
            case .success(let movieData):
                print("Data was fetched successfully! Data: \(movieData)")
                completion(movieData, nil)
            }
        }
    }
}
