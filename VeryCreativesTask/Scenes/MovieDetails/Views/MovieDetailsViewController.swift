//
//  MovieDetailsViewController.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit

protocol MovieDetailsViewControllerProtocol: AnyObject {
    
}

class MovieDetailsViewController: UIViewController, MovieDetailsViewControllerProtocol {
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieOverviewLabel: UILabel!
    
    var detailsPresenter: MovieDetailsPresenterProtocol?
    private var favButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteButton()
        setupViews()
    }
    
    private func setupViews() {
        movieNameLabel.text = detailsPresenter?.movie?.title ?? ""
        movieImage.kf.setImage(with: Constants.noImage)
        movieOverviewLabel.text = detailsPresenter?.movie?.overview ?? ""
    }
    
    private func setupFavoriteButton() {
        if #available(iOS 13.0, *) {
            favButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapFavButton))
            self.navigationItem.rightBarButtonItem  = favButton
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @objc private func didTapFavButton() {
        guard let movie = detailsPresenter?.movie, let presenter = detailsPresenter else { return }
        
        if #available(iOS 13.0, *) {
            
            if presenter.isMovieFavorited(movie: movie) {
                favButton?.image = UIImage(systemName: "star.fill")
                //Do logic to put movie in favorites
            } else {
                favButton?.image = UIImage(systemName: "star")
                //Do logic to delete movie in favorites
            }
            
            
        } else {
            // Fallback on earlier versions
        }
    }
    
}
