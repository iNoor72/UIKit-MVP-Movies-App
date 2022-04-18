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
    
    //MARK: IBOutlets
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    //MARK: Variables
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
    
    //MARK: Helper Functions
    private func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor(rgb: Constants.Colors.primaryYellowColor)
        title = NSLocalizedString("Details", comment: "")
        guard let imageURL = URL(string: Constants.imagesBaseURL + (detailsPresenter?.movie?.backdrop_path ?? Constants.noImageURL)) else { return }
        
        movieNameLabel.text = detailsPresenter?.movie?.title ?? ""
        movieImage.kf.setImage(with: imageURL)
        movieOverviewTextView.text = detailsPresenter?.movie?.overview ?? ""
        movieOverviewTextView.layer.borderColor = UIColor(rgb: Constants.Colors.primaryYellowColor).cgColor
        movieOverviewTextView.layer.borderWidth = 0.7
        movieOverviewTextView.layer.cornerRadius = 8.0
        
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
    
    //MARK: @objc functions
    @objc private func didTapFavButton() {
        guard let presenter = detailsPresenter, let movie = detailsPresenter?.movie else { return }
        
        if #available(iOS 13.0, *) {
            
            if presenter.isMovieFavorited(movie: movie) {
                favButton?.image = UIImage(systemName: "star")
                detailsPresenter?.movie?.movieState = .normal
                let _ = NetworkDataRepository.shared.fetchedMovies.map { movieToBeUnsaved in
                    if movieToBeUnsaved.id == movie.id {
                        movieToBeUnsaved.movieState = .normal
                    }
                }
                detailsPresenter?.deleteMovieFromFavorites(movie: movie)
                
            } else {
                favButton?.image = UIImage(systemName: "star.fill")
                detailsPresenter?.movie?.movieState = .favorited
                let _ = NetworkDataRepository.shared.fetchedMovies.map { movieToBeUnsaved in
                    if movieToBeUnsaved.id == movie.id {
                        movieToBeUnsaved.movieState = .favorited
                    }
                }
                detailsPresenter?.saveMovieAsFavorite(movie: movie)
            }
        }
        
        else {
            // Fallback on earlier versions
        }
    }
    
}
