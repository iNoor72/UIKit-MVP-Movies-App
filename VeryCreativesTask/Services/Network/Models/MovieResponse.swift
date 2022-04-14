//
//  MovieResponse.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//.

import Foundation

struct MovieResponse: Codable {
    let results: [MovieData]?
    let totalResults, totalPages, page: Int?
       enum CodingKeys: String, CodingKey {
           case page, results
           case totalResults
           case totalPages
       }
   }

struct MovieData: Codable {
    var id: Int?
    var title: String?
    var overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
    }
}
