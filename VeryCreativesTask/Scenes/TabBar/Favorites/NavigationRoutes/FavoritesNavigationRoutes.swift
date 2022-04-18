//
//  FavoritesNavigationRoutes.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 15/04/2022.
//

import Foundation
import UIKit

enum FavoritesNavigationRoutes: Route {
    case MovieDetails(MovieData)
    
    var destination: UIViewController {
        switch self {
        case .MovieDetails(let movie):
            let MovieDetailsViewController = MovieDetailsViewController(nibName: Constants.XIBs.MovieDetailsViewController, bundle: nil)
            MovieDetailsViewController.detailsPresenter = MovieDetailsPresenter(movie: movie, detailsView: MovieDetailsViewController)
            
            return MovieDetailsViewController
        }
    }
    
    var style: NavigationStyle {
        switch self {
        case .MovieDetails(_):
            return .push
        }
    }
    
    
}

