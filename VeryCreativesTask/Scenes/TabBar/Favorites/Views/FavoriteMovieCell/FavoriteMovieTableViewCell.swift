//
//  FavoriteMovieTableViewCell.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit
import Kingfisher

class FavoriteMovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var unfavoriteButton: UIButton!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    
    private var isMovieFavorited = true
    private var movie: MovieDataManagedObject?
    private var delegate: FavoritesViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        unfavoriteButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let movie = movie else { return }
        
        if #available(iOS 13.0, *) {
            if isMovieFavorited {
                unfavoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                isMovieFavorited.toggle()
                
                //Logic to delete movie
                delegate?.userUnfavoritedMovie(movie: movie)
                
            } else {
                unfavoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                isMovieFavorited.toggle()
                
                //Logic to favorite movie
                delegate?.userRefavoritedMovie(movie: movie)
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func userUnfavoritedMovie(movie: MovieDataManagedObject) {
        
    }
    
    func configure(movie: MovieDataManagedObject, delegate: FavoritesViewControllerDelegate) {
        guard let imageURL = URL(string: (Constants.imagesBaseURL + (movie.imageURL ?? ""))), let _ = movieRatingLabel.text else { return }
        
        self.movieImage.kf.setImage(with: imageURL)
        self.movie = movie
        self.delegate = delegate
        self.movieNameLabel.text = movie.title
        self.movieRatingLabel.text! = "Rating: \(movie.rating)/10"
    }
    
}
