//
//  MovieResponse.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//.

import Foundation

struct MovieResponse: Codable {
    var results: [MovieData]?
    var totalPages, page: Int?
       enum CodingKeys: String, CodingKey {
           case page, results
           case totalPages
       }
   }

struct MovieData: Codable {
    var id: Int?
    var title: String?
    var overview: String?
    var poster_path: String?
    var backdrop_path: String?
    var vote_average: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster_path, backdrop_path
        case vote_average
    }
}
