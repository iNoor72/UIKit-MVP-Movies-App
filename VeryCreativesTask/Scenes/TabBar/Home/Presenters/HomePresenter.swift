//
//  HomePresenter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation

protocol HomePresenterProtocol {
    var moviesList: [MovieDataManagedObject] { get }
    var popularMoviesList: MovieResponse? { get }
    var topRatedMoviesList: MovieResponse? { get }
    var userMoviePreference: MoviesType { get set }
    
    func fetchPopularMovies()
    func fetchTopRatedMovies()
}

enum MoviePreference {
    case top
}

class HomePresenter: HomePresenterProtocol {
    
    var moviesList = [MovieDataManagedObject]()
    var popularMoviesList: MovieResponse?
    var topRatedMoviesList: MovieResponse?
    var userMoviePreference: MoviesType = .topRated
    weak var homeView: HomeViewControllerProtocol?
    
    init(homeView: HomeViewControllerProtocol) {
        self.homeView = homeView
    }
    
    func setMoviesList(movies: [MovieDataManagedObject]) {
        self.moviesList = movies
    }
    
    func fetchPopularMovies() {
        NetworkManager.shared.fetchMovies(type: .popular) {[weak self] (movies: MovieResponse?, error) in
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
        NetworkManager.shared.fetchMovies(type: .topRated) {[weak self] (movies: MovieResponse?, error) in
            if error != nil {
                print("There was an error fetching data in presenter. Error: \(error!.localizedDescription)")
            }
            
            
            self?.topRatedMoviesList = movies
            
            DispatchQueue.main.async {
                self?.homeView?.reloadData()
            }
        }
    }
    
    
}
