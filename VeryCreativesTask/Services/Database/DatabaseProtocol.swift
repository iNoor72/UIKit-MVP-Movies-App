//
//  DatabaseProtocol.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation

protocol DatabaseProtocol {
    func save(movie: MovieData)
    func fetch() -> [Int] //Returns array of IDs
    func delete(movie: MovieData)
}
