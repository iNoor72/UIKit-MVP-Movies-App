//
//  CoreDataTests.swift
//  VeryCreativesTaskTests
//
//  Created by Noor Walid on 17/04/2022.
//

@testable import VeryCreativesTask
import XCTest
import CoreData


class CoreDataTests: XCTestCase {
    
    var sut: DatabaseProtocol!
    
    override func setUp() {
        super.setUp()
        sut = CoreDataManager(modelName: Constants.CoreDataModelFile)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetching_favorite_movies() {
        
    }
    
    func test_saving_favorite_movie() {
        
    }
    
    func test_deleting_an_existing_favorite_movie() {
        
    }
    
    func test_deleting_non_existing_movie() {
        
    }
}
