//
//  MovieDetailsPresenter.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation

//MARK: Protocols
protocol MovieDetailsPresenterProtocol {
    var movie: MovieData? { get set }
    
    func isMovieFavorited(movie: MovieData) -> Bool
    func saveMovieAsFavorite(movie: MovieData)
    func deleteMovieFromFavorites(movie: MovieData) 
    
}

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    //MARK: Variables
    var movie: MovieData?
    weak var detailsView: MovieDetailsViewControllerProtocol?
    private let DatabaseManager : DatabaseProtocol
    
    init(DatabaseManager: DatabaseProtocol = CoreDataManager(modelName: Constants.CoreDataModelFile), movie: MovieData, detailsView: MovieDetailsViewControllerProtocol) {
        self.movie = movie
        self.detailsView = detailsView
        self.DatabaseManager = DatabaseManager
    }
    
    //MARK: Protocol Functions
    func saveMovieAsFavorite(movie: MovieData) {
        DatabaseManager.save(movie: movie)
    }
    
    func deleteMovieFromFavorites(movie: MovieData) {
        DatabaseManager.delete(movie: movie)
    }
    
    func isMovieFavorited(movie: MovieData) -> Bool {
        guard let favMovieModels = DatabaseManager.fetch() else { return false }
        guard let movieID = movie.id else { return false }
        for movieModel in favMovieModels {
            if movieModel.id == Int32(movieID) {
                return true
            }
        }
        return false
    }
    
}
