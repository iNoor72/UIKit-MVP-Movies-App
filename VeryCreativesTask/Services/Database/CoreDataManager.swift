//
//  CoreDataManager.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation
import CoreData

final class CoreDataManager: DatabaseProtocol {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("There was a problem saving model to Core Data. Error: \(error)")
            }
        }
    }
    
    func save(movie: MovieData) {
        let managedMovie = MovieDataManagedObject(context: managedObjectContext)
        guard let movieID = movie.id else { return }
        
        managedMovie.id = Int32(movieID)
        managedMovie.title = movie.title
        managedMovie.overview = movie.overview
        managedMovie.imageURL = movie.poster_path
        managedMovie.rating = movie.vote_average ?? 0
        managedMovie.state = movie.movieState.rawValue
        
        saveContext()
    }
    
    func fetch() -> [MovieDataManagedObject] {
        var moviesArray = [MovieDataManagedObject]()
        let fetchRequest = NSFetchRequest<MovieDataManagedObject>(entityName: "MovieDataManagedObject")
        do {
            let favoriteMovies = try managedObjectContext.fetch(fetchRequest)
            for movie in favoriteMovies {
                moviesArray.append(movie)
            }
            return moviesArray
        } catch {
            print("There was a problem fetching data from Core Data. Error: \(error)")
        }

        return moviesArray
    }
    
    func delete(movie: MovieData) {
        guard let movieID = movie.id else { return } //ID of movie to be deleted
        var favoriteMoviesList: [MovieDataManagedObject]
        
        let fetchRequest = NSFetchRequest<MovieDataManagedObject>(entityName: "MovieDataManagedObject")
        do {
            favoriteMoviesList = try managedObjectContext.fetch(fetchRequest)
            
            for favoriteMovie in favoriteMoviesList {
                if favoriteMovie.id == Int32(movieID) {
                    //Delete from Core Data stack
                    managedObjectContext.delete(favoriteMovie)
                    saveContext()
                    break
                }
            }
            
        } catch {
            print("There was a problem fetching data from Core Data. Error: \(error)")
        }
    }
    
    func convertModelToResponse(model: MovieDataManagedObject) -> MovieData? {
        for movie in NetworkRepository.shared.fetchedMovies {
            if model.id == movie.id ?? 0 {
                return movie
            }
        }
        
        return nil
        
    }
    
    func convertResponseToModel(movie: MovieData) -> MovieDataManagedObject? {
        let favMovieModels = fetch()
        guard let movieID = movie.id else { return nil }
        for movieModel in favMovieModels {
            if movieModel.id == Int32(movieID) {
                return movieModel
            }
        }
        
        return nil
    }
    
    
    
}
