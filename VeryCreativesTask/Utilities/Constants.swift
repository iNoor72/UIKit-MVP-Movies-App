//
//  Constants.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let CoreDataModelFile = "Model"
    static let APIKey = "8d61230b01928fe55a53a48a41dc839b"
    static let dummyURL = URL(string: "https://google.com")!
    static let noImage = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png")!
    
    struct Storyboards {
        static let MainStoryboard = "Main"
    }
    
    struct XIBs {
        static let FavoriteMovieTableViewCell = "FavoriteMovieTableViewCell"
        static let MovieCollectionViewCell = "MovieCollectionViewCell"
        static let MovieDetailsViewController = "MovieDetailsViewController"
    }
    
    struct ViewControllers {
        static let HomeViewController = "HomeViewController"
        static let FavoritesViewController = "FavoritesViewController"
        static let MovieDetailsViewController = "MovieDetailsViewController"
    }
    
    struct CollectionViewCells {
        static let MovieCell = "MovieCell"
    }
    
    struct TableViewCells {
        static let FavoriteMovieCell = "FavoriteMovieCell"
    }
    
}
