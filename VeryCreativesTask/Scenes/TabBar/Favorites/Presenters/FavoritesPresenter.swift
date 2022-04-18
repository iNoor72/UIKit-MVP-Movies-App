//
//  FavoritesPresenter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation

//MARK: Protocols
protocol FavoritesPresenterProtocol {
    var favoritedMovies: [MovieDataManagedObject]? { get }
    
    func fetchFavoriteMovies()
    func saveMovieAsFavorite(movie: MovieDataManagedObject)
    func deleteMovieFromFavorites(movie: MovieDataManagedObject)
    func navigateToMovie(at index: Int)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    //MARK: Variables
    var favoritedMovies: [MovieDataManagedObject]?
    weak var favoritesView: FavoritesViewControllerProtocol?
    private var DatabaseManager : DatabaseProtocol
    
    init(DatabaseManager: DatabaseProtocol = CoreDataManager(modelName: Constants.CoreDataModelFile), favoritesView: FavoritesViewControllerProtocol) {
        self.favoritesView = favoritesView
        self.DatabaseManager = DatabaseManager
    }
    
    //MARK: Protocol Functions
    func fetchFavoriteMovies() {
        favoritedMovies = DatabaseManager.fetch()
        favoritesView?.reloadData()
    }
    
    func saveMovieAsFavorite(movie: MovieDataManagedObject) {
        guard let movie = DatabaseManager.convertModelToResponse(model: movie) else { return }
        DatabaseManager.save(movie: movie)
    }
    
    func deleteMovieFromFavorites(movie: MovieDataManagedObject) {
        guard let movie = DatabaseManager.convertModelToResponse(model: movie) else { return }
        DatabaseManager.delete(movie: movie)
        fetchFavoriteMovies()
    }
    
    
    func navigateToMovie(at index: Int) {
        guard let model = favoritedMovies?[index] else { return }
        guard let movie = DatabaseManager.convertModelToResponse(model: model) else { return }
        let route = FavoritesNavigationRoutes.MovieDetails(movie)
        favoritesView?.navigate(to: route)
    }
    
}
