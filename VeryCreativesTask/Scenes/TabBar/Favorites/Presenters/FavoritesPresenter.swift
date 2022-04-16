//
//  FavoritesPresenter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation

protocol FavoritesPresenterProtocol {
    var favoritedMovies: [MovieDataManagedObject]? { get }
    var moviesToBeDeleted: [MovieDataManagedObject]? { get }
    var movieState: MovieState? { get }
    
    func fetchFavoriteMovies()
    func navigateToMovie(at index: Int)
    func deleteMovies(movies: [MovieDataManagedObject])
    func saveMovieAsFavorite(movie: MovieDataManagedObject)
    func deleteMovieFromFavorites(movie: MovieDataManagedObject)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    var favoritedMovies: [MovieDataManagedObject]?
    var moviesToBeDeleted: [MovieDataManagedObject]?
    var movieState: MovieState?
    weak var favoritesView: FavoritesViewControllerProtocol?
    private var DatabaseManager : DatabaseProtocol
    
    init(DatabaseManager: DatabaseProtocol = CoreDataManager(modelName: Constants.CoreDataModelFile), favoritesView: FavoritesViewControllerProtocol) {
        self.favoritesView = favoritesView
        self.DatabaseManager = DatabaseManager
    }
    
    func fetchFavoriteMovies() {
        favoritedMovies = DatabaseManager.fetch()
        favoritesView?.reloadData()
    }
    
    func navigateToMovie(at index: Int) {
        //Need to change to reponse data movie
        guard let model = favoritedMovies?[index] else { return }
        let movie = convertModelToResponse(model: model)
        let route = FavoritesNavigationRoutes.MovieDetails(movie)
        favoritesView?.navigate(to: route)
    }
    
    func deleteMovies(movies: [MovieDataManagedObject]) {
        for movieModel in movies {
            let movie = convertModelToResponse(model: movieModel)
            DatabaseManager.delete(movie: movie)
        }
    }
    
    func saveMovieAsFavorite(movie: MovieDataManagedObject) {
        let movie = convertModelToResponse(model: movie)
        DatabaseManager.save(movie: movie)
    }
    
    func deleteMovieFromFavorites(movie: MovieDataManagedObject) {
        let movie = convertModelToResponse(model: movie)
        DatabaseManager.delete(movie: movie)
    }
    
    func convertModelToResponse(model: MovieDataManagedObject) -> MovieData {
        for movie in NetworkRepository.shared.fetchedMovies {
            if model.id == movie.id ?? 0 {
                return movie
            }
        }
        return MovieData()
    }
    
    
}
