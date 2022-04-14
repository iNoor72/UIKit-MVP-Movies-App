//
//  MovieResponseManagedObject+CoreDataProperties.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 15/04/2022.
//
//

import Foundation
import CoreData


extension MovieResponseManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieResponseManagedObject> {
        return NSFetchRequest<MovieResponseManagedObject>(entityName: "MovieResponseManagedObject")
    }

    @NSManaged public var page: Int32
    @NSManaged public var total_pages: Int32
    @NSManaged public var movies: NSObject?
    @NSManaged public var moviesList: NSSet?

}

// MARK: Generated accessors for moviesList
extension MovieResponseManagedObject {

    @objc(addMoviesListObject:)
    @NSManaged public func addToMoviesList(_ value: MovieDataManagedObject)

    @objc(removeMoviesListObject:)
    @NSManaged public func removeFromMoviesList(_ value: MovieDataManagedObject)

    @objc(addMoviesList:)
    @NSManaged public func addToMoviesList(_ values: NSSet)

    @objc(removeMoviesList:)
    @NSManaged public func removeFromMoviesList(_ values: NSSet)

}
