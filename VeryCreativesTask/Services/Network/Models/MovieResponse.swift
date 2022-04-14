//
//  MovieResponse.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation

struct MovieResponse: Codable {
    var page: Int?
    var results: [MovieData]?
    var total_pages: Int?
    
}

struct MovieData: Codable {
    var id: Int?
    var title: String?
    var overview: String?
}
