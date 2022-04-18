//
//  HomePresenter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation

//MARK: Protocols
protocol HomePresenterProtocol {
    var popularMoviesList: MovieResponse? { get }
    var topRatedMoviesList: MovieResponse? { get }
    var userMoviePreference: MovieType { get set }
    
    func fetchPopularMovies(page: Int)
    func fetchTopRatedMovies(page: Int)
    func navigateToMovie(at index: Int)
}

class HomePresenter: HomePresenterProtocol {
    
    //MARK: Variables
    var popularMoviesList: MovieResponse?
    var topRatedMoviesList: MovieResponse?
    var userMoviePreference: MovieType = .topRated
    
    //MARK: Variables
    private let DatabaseManager : DatabaseProtocol
    private let network: NetworkService
    weak var homeView: HomeViewControllerProtocol?
    
    //MARK: Init
    init(network: NetworkService = NetworkManager.shared, DatabaseManager: DatabaseProtocol = CoreDataManager(modelName: Constants.CoreDataModelFile), homeView: HomeViewControllerProtocol) {
        self.DatabaseManager = DatabaseManager
        self.homeView = homeView
        self.network = network
    }
    
    
    //MARK: Protocol Functions
    func fetchPopularMovies(page: Int = 1) {
        let url = NetworkRouter.popular(page: page)
        network.fetchData(url: url, expectedType: MovieResponse.self, completion: {[weak self] result in
            switch result {
            case .failure(let error):
                print("There was an error fetching data in presenter. Error: \(error.localizedDescription)")
            case .success(let movies):
                if self?.popularMoviesList == nil {
                    guard let moviesArray = movies.results else { return }
                    self?.popularMoviesList = movies
                    NetworkDataRepository.shared.fetchedMovies += moviesArray
                } else {
                    guard let moreMovies = movies.results else { return }
                    self?.popularMoviesList?.results! += moreMovies
                    NetworkDataRepository.shared.fetchedMovies += moreMovies
                }
                
                DispatchQueue.main.async {
                    self?.homeView?.reloadData()
                }
                
            }
        })
    }
    
    func fetchTopRatedMovies(page: Int = 1) {
        let url = NetworkRouter.topRated(page: page)
        network.fetchData(url: url, expectedType: MovieResponse.self) {[weak self] result in
            switch result {
            case .failure(let error):
                print("There was an error fetching data in presenter. Error: \(error.localizedDescription)")
            case .success(let movies):
                if self?.topRatedMoviesList == nil {
                    guard let moviesArray = movies.results else { return }
                    self?.topRatedMoviesList = movies
                    NetworkDataRepository.shared.fetchedMovies += moviesArray
                } else {
                    guard let moreMovies = movies.results else { return }
                    self?.topRatedMoviesList?.results! += moreMovies
                    NetworkDataRepository.shared.fetchedMovies += moreMovies
                }
                
                DispatchQueue.main.async {
                    self?.homeView?.reloadData()
                }
                
            }
        }
    }
    
    func navigateToMovie(at index: Int) {
        switch userMoviePreference {
        case .topRated:
            guard let movie = topRatedMoviesList?.results?[index] else { return }
            let movieModel = DatabaseManager.convertResponseToModel(movie: movie)
            if let _ = movieModel {
                movie.movieState = .favorited
                let route = HomeNavigationRoutes.MovieDetails(movie)
                homeView?.navigate(to: route)
            } else {
                let route = HomeNavigationRoutes.MovieDetails(movie)
                homeView?.navigate(to: route)
            }
            
        case .popular:
            guard let movie = popularMoviesList?.results?[index] else { return }
            let movieModel = DatabaseManager.convertResponseToModel(movie: movie)
            if let _ = movieModel {
                movie.movieState = .favorited
                let route = HomeNavigationRoutes.MovieDetails(movie)
                homeView?.navigate(to: route)
            } else {
                let route = HomeNavigationRoutes.MovieDetails(movie)
                homeView?.navigate(to: route)
            }
        }
        
    }
}
