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
    case image(path: String)

    var path: String {
        switch self {
        case .topRated:
            return "/movie/top_rated"
        case .popular:
            return "/movie/popular"
        case .movie(let movieID):
            return "/movie/\(movieID)"
        case .image(let path):
            return "/\(path)"
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
        case .image(_):
            return .get
        }
    }
    
    //We don't need headers but if needed, uncomment the code and write the headers
    
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
            return ["api_key":"\(Constants.APIKey)"]
        case .popular:
            return ["api_key":"\(Constants.APIKey)"]
        case .movie(let movieID):
            return ["movie_id":movieID,
                    "api_key":"\(Constants.APIKey)"]
        case .image(_):
            return ["":""]
        }
    }
    
    
    
    
    func asURLRequest() throws -> URLRequest {
        guard var safeURL = URL(string: Constants.baseURL) else { return URLRequest(url: Constants.dummyURL) }
        safeURL.appendPathComponent(path)
        var request = URLRequest(url: safeURL)
        request.method = method
        switch self {
        default:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        
        return request
    }
}
