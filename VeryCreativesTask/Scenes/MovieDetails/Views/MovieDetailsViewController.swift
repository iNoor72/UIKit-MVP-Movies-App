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
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFavoriteButton()
    }
    
    private func setupViews() {
        title = "Details"
        guard let imageURL = URL(string: Constants.imagesBaseURL + (detailsPresenter?.movie?.backdrop_path ?? "")) else { return }
        
        movieNameLabel.text = detailsPresenter?.movie?.title ?? ""
        movieImage.kf.setImage(with: imageURL)
        movieOverviewLabel.text = detailsPresenter?.movie?.overview ?? ""
    }
    
    private func setupFavoriteButton() {
        if #available(iOS 13.0, *) {
            //Set the button based on the movie state
            guard let movie = detailsPresenter?.movie else { return }
            let isMovieFavorited = detailsPresenter?.isMovieFavorited(movie: movie) ?? false
            
            let buttonImage = isMovieFavorited ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            
            favButton = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(didTapFavButton))
            favButton?.tintColor = UIColor.systemYellow
            self.navigationItem.rightBarButtonItem  = favButton
            

        }
        
        
        else {
            // Fallback on earlier versions
        }
        
    }
    
    @objc private func didTapFavButton() {
        guard let presenter = detailsPresenter, let movie = detailsPresenter?.movie else { return }
        
        if #available(iOS 13.0, *) {
            
            if presenter.isMovieFavorited(movie: movie) {
                favButton?.image = UIImage(systemName: "star")
                detailsPresenter?.movie?.movieState = .normal
                detailsPresenter?.deleteMovieFromFavorites(movie: movie)
                
            } else {
                favButton?.image = UIImage(systemName: "star.fill")
                detailsPresenter?.movie?.movieState = .favorited
                detailsPresenter?.saveMovieAsFavorite(movie: movie)
            }
            
            
        } else {
            // Fallback on earlier versions
        }
    }
    
}
