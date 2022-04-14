//
//  FavoritesPresenter.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import Foundation

protocol FavoritesPresenterProtocol {
    
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    weak var favoritesView: FavoritesViewControllerProtocol?
    
    init(favoritesView: FavoritesViewControllerProtocol) {
        self.favoritesView = favoritesView
    }
}
