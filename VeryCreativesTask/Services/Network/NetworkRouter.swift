//
//  NetworkRouter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation
import Alamofire


enum NetworkRouter: URLRequestConvertible {
    case topRated(page: Int)
    case popular(page: Int)
    case movie(id: Int)

    var path: String {
        switch self {
        case .topRated:
            return "/movie/top_rated"
        case .popular:
            return "/movie/popular"
        case .movie(let movieID):
            return "/movie/\(movieID)"
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
        case .topRated(let page):
            return ["api_key":"\(Constants.APIKey)", "page":page]
        case .popular(let page):
            return ["api_key":"\(Constants.APIKey)", "page":page]
        case .movie(let movieID):
            return ["movie_id":movieID,
                    "api_key":"\(Constants.APIKey)"]
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
