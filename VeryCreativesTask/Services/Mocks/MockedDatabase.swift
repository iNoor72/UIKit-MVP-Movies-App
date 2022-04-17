//
//  MockedDatabase.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 17/04/2022.
//

import Foundation

class MockedDatabase: DatabaseProtocol {
    func deleteAll() {
        
    }
    
    func save(movie: MovieData) {
        
    }
    
    func delete(movie: MovieData) {
        
    }
    
    func fetch() -> [MovieDataManagedObject] {
     
        return [MovieDataManagedObject]()
    }
    
    func convertModelToResponse(model: MovieDataManagedObject) -> MovieData? {
        
        return nil
    }
    
    func convertResponseToModel(movie: MovieData) -> MovieDataManagedObject? {
        
        return nil
    }
    
    
}
