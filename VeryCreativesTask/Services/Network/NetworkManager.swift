//
//  NetworkManager.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation
import Alamofire

enum MoviesType {
    case topRated
    case popular
    case favorites
}


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private func getURL(type: MoviesType) -> NetworkRouter {
        switch type {
        case .popular:
            return NetworkRouter.popular
        case .topRated:
            return NetworkRouter.topRated
        case .favorites:
            break
        }
        
        return NetworkRouter.topRated
    }
    
    func fetchMovies<T:Decodable>(type: MoviesType, completion: @escaping (T?, Error?) -> ()) {
        let url = getURL(type: type)
//        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(Constants.APIKey)")!
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
