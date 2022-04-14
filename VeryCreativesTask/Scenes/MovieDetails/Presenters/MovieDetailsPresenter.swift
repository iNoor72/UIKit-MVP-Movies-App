//
//  MovieDetailsPresenter.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation

protocol MovieDetailsPresenterProtocol {
    var movie: MovieData? { get }
    
    func isMovieFavorited(movie: MovieData) -> Bool
    
}

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    var movie: MovieData?
    weak var detailsView: MovieDetailsViewControllerProtocol?
    
    init(movie: MovieData, detailsView: MovieDetailsViewControllerProtocol) {
        self.movie = movie
        self.detailsView = detailsView
    }
    
    
    
    
    func isMovieFavorited(movie: MovieData) -> Bool {
     
        return false
    }
    
}
