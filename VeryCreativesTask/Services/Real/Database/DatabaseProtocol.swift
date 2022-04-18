//
//  DatabaseProtocol.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation

protocol DatabaseProtocol {
    func save(movie: MovieData)
    func delete(movie: MovieData)
    func deleteAll()
    func fetch() -> [MovieDataManagedObject]
    func convertModelToResponse(model: MovieDataManagedObject) -> MovieData?
    func convertResponseToModel(movie: MovieData) -> MovieDataManagedObject? 
}
