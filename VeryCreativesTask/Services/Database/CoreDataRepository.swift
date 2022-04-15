//
//  CoreDataRepository.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 16/04/2022.
//

import Foundation

class CoreDataRepository {
    static let shared = CoreDataRepository()
    var favoriteMovies = [MovieDataManagedObject]()
    private init() {}
}
