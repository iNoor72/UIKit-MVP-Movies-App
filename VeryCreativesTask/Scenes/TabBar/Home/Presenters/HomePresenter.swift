//
//  HomePresenter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation

protocol HomePresenterProtocol {
    var favoriteMovieList: [MovieDataManagedObject]? { get }
    var popularMoviesList: MovieResponse? { get }
    var topRatedMoviesList: MovieResponse? { get }
    var userMoviePreference: MovieType { get set }
    
    func fetchPopularMovies()
    func fetchTopRatedMovies()
    func fetchFavoriteMovies()
    func navigateToMovie(at index: Int)
}

class HomePresenter: HomePresenterProtocol {
    
    var favoriteMovieList : [MovieDataManagedObject]?
    var popularMoviesList: MovieResponse?
    var topRatedMoviesList: MovieResponse?
    var userMoviePreference: MovieType = .topRated
    private let DatabaseManager : DatabaseProtocol
    weak var homeView: HomeViewControllerProtocol?
    
    init(DatabaseManager: DatabaseProtocol = CoreDataManager(modelName: Constants.CoreDataModelFile), homeView: HomeViewControllerProtocol) {
        self.DatabaseManager = DatabaseManager
        self.homeView = homeView
        
        //For now only
        self.favoriteMovieList = [MovieDataManagedObject]()
    }
    
//    func setMoviesList(movies: [MovieDataManagedObject]) {
//        self.favoriteMovieList = movies
//    }
    
    func fetchPopularMovies() {
        NetworkManager.shared.fetchMovies(type: MovieType.popular) {[weak self] (movies: MovieResponse?, error: Error?) in
            if error != nil {
                print("There was an error fetching data in presenter. Error: \(error!.localizedDescription)")
            }
            
            
            self?.popularMoviesList = movies
            
            DispatchQueue.main.async {
                self?.homeView?.reloadData()
            }
        }
    }
    
    func fetchTopRatedMovies() {
        NetworkManager.shared.fetchMovies(type: MovieType.topRated) {[weak self] (movies: MovieResponse?, error: Error?) in
            if error != nil {
                print("There was an error fetching data in presenter. Error: \(error!.localizedDescription)")
            }
            
            
            self?.topRatedMoviesList = movies
            
            DispatchQueue.main.async {
                self?.homeView?.reloadData()
            }
        }
    }
    
    func fetchFavoriteMovies() {
        DatabaseManager.fetch()
    }
    
    func navigateToMovie(at index: Int) {
        switch userMoviePreference {
        case .topRated:
            guard let movie = topRatedMoviesList?.results?[index] else { return }
            let route = HomeNavigationRoutes.MovieDetails(movie)
            homeView?.navigate(to: route)

        case .popular:
            guard let movie = popularMoviesList?.results?[index] else { return }
            let route = HomeNavigationRoutes.MovieDetails(movie)
            homeView?.navigate(to: route)
        case .favorites:
            guard let movie = favoriteMovieList?[index] else { return }
            //Yet to be implemented
//            let route = HomeNavigationRoutes.MovieDetails(movie)
//            homeView?.navigate(to: route)
        }
        
    }
    
    
}
