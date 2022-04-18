//
//  MovieDataManagedObject+CoreDataProperties.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 16/04/2022.
//
//

import Foundation
import CoreData


extension MovieDataManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDataManagedObject> {
        return NSFetchRequest<MovieDataManagedObject>(entityName: "MovieDataManagedObject")
    }

    @NSManaged public var id: Int32
    @NSManaged public var imageURL: String?
    @NSManaged public var overview: String?
    @NSManaged public var rating: Double
    @NSManaged public var title: String?
    @NSManaged public var state: String?

}
