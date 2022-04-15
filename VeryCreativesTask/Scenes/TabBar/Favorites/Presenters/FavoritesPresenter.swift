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
    
    func fetchFavoriteMovies()
    func navigateToMovie(at index: Int)
    func deleteMovies(movies: [MovieDataManagedObject])
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    var favoritedMovies: [MovieDataManagedObject]?
    var moviesToBeDeleted: [MovieDataManagedObject]?
    weak var favoritesView: FavoritesViewControllerProtocol?
    private let DatabaseManager : DatabaseProtocol = CoreDataManager(modelName: Constants.CoreDataModelFile)
    
    init(favoritesView: FavoritesViewControllerProtocol) {
        self.favoritesView = favoritesView
    }
    
    func fetchFavoriteMovies() {
        favoritedMovies = DatabaseManager.fetch()
        favoritesView?.reloadData()
    }
    
    func navigateToMovie(at index: Int) {
        //Need to change to reponse data movie
        guard let movie = favoritedMovies?[index] else { return }
//        let route = FavoritesNavigationRoutes.MovieDetails(movie)
//        homeView?.navigate(to: route)
    }
    
    func deleteMovies(movies: [MovieDataManagedObject]) {
        for movie in movies {
//            DatabaseManager.delete(movie: movie)
        }
    }
}
