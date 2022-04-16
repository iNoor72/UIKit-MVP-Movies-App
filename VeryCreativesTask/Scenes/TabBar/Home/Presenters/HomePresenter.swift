//
//  HomePresenter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation

protocol HomePresenterProtocol {
//    var favoriteMovieList: [MovieDataManagedObject]? { get }
    var popularMoviesList: MovieResponse? { get }
    var topRatedMoviesList: MovieResponse? { get }
    var userMoviePreference: MovieType { get set }
    
    func fetchPopularMovies(page: Int)
    func fetchTopRatedMovies(page: Int)
//    func fetchFavoriteMovies()
    func navigateToMovie(at index: Int)
    func convertModelToResponse(model: MovieDataManagedObject) -> MovieData
}

class HomePresenter: HomePresenterProtocol {
    
//    var favoriteMovieList : [MovieDataManagedObject]?
    var popularMoviesList: MovieResponse?
    var topRatedMoviesList: MovieResponse?
    var userMoviePreference: MovieType = .topRated
    private let DatabaseManager : DatabaseProtocol
    weak var homeView: HomeViewControllerProtocol?
    
    init(DatabaseManager: DatabaseProtocol = CoreDataManager(modelName: Constants.CoreDataModelFile), homeView: HomeViewControllerProtocol) {
        self.DatabaseManager = DatabaseManager
        self.homeView = homeView
    }
    
    func fetchPopularMovies(page: Int = 1) {
        NetworkManager.shared.fetchMovies(page: page, type: MovieType.popular) {[weak self] (movies: MovieResponse?, error: Error?) in
            if error != nil {
                print("There was an error fetching data in presenter. Error: \(error!.localizedDescription)")
            }
            
            if self?.popularMoviesList == nil {
                guard let moviesArray = movies?.results else { return }
                self?.popularMoviesList = movies
                NetworkRepository.shared.fetchedMovies += moviesArray
            } else {
                guard let moreMovies = movies?.results else { return }
                self?.popularMoviesList?.results! += moreMovies
                NetworkRepository.shared.fetchedMovies += moreMovies
            }
            
            
            DispatchQueue.main.async {
                self?.homeView?.reloadData()
            }
        }
    }
    
    func fetchTopRatedMovies(page: Int = 1) {
        NetworkManager.shared.fetchMovies(page: page, type: MovieType.topRated) {[weak self] (movies: MovieResponse?, error: Error?) in
            if error != nil {
                print("There was an error fetching data in presenter. Error: \(error!.localizedDescription)")
            }
            
            if self?.topRatedMoviesList == nil {
                guard let moviesArray = movies?.results else { return }
                self?.topRatedMoviesList = movies
                NetworkRepository.shared.fetchedMovies += moviesArray
            } else {
                guard let moreMovies = movies?.results else { return }
                self?.topRatedMoviesList?.results! += moreMovies
                NetworkRepository.shared.fetchedMovies += moreMovies
            }
            
            DispatchQueue.main.async {
                self?.homeView?.reloadData()
            }
        }
    }
    
//    func fetchFavoriteMovies() {
//        favoriteMovieList = DatabaseManager.fetch()
//    }
    
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
        }
        
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
