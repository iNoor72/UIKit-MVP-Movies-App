//
//  NetworkRouter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation
import Alamofire


enum NetworkRouter: URLRequestConvertible {
    case topRated
    case popular
    case movie(id: Int)
    
    var path: String {
        switch self {
        case .topRated:
            return "/movie/top_rated?\(Constants.APIKey)"
        case .popular:
            return "/movie/popular?\(Constants.APIKey)"
        case .movie(let movieID):
            return "/movie/\(movieID)?\(Constants.APIKey)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .topRated:
            return .get
        case .popular:
            return .get
        case .movie(_):
            return .get
        }
    }
    
    //They're not needed, but uncomment and add header if there's any
//    var headers: [String:String] {
//        switch self {
//        case .topRated:
//            return ["":""]
//        case .popular:
//            return ["":""]
//        case .movie(_):
//            return ["":""]
//        }
//    }
    
    var parameters: [String: Any] {
        switch self {
        case .topRated:
            return ["":""]
        case .popular:
            return ["":""]
        case .movie(let movieID):
            return ["movie_id":movieID]
        }
    }
    
    
    
    
    func asURLRequest() throws -> URLRequest {
        guard let safeURL = URL(string: Constants.baseURL) else { return URLRequest(url: Constants.dummyURL) }
        var request = URLRequest(url: safeURL)
        request.method = method
        switch self {
        case .movie(id: _):
            request = try URLEncoding.default.encode(request, with: parameters)
        default:
            print("No params for this request.")
        }
        
        return request
    }
}
