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
        AF.request("").responseDecodable { (response : DataResponse<T, AFError>) in
            switch response.result {
            case .failure(let error):
                print("There was a problem fetching data form API. Error: \(error)")
                completion(nil, error)
                
            case .success(let data):
                print("Data was fetched successfully! Data: \(data)")
                completion(data, nil)
            }
        }
    }
}
