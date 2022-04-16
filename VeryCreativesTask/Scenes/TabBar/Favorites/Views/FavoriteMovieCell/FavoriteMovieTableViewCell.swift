//
//  FavoriteMovieTableViewCell.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit
import Kingfisher

class FavoriteMovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    
    private var isMovieFavorited = true
    private var movie: MovieDataManagedObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(movie: MovieDataManagedObject) {
        guard let imageURL = URL(string: (Constants.imagesBaseURL + (movie.imageURL ?? ""))), let _ = movieRatingLabel.text else { return }
        
        self.movieImage.kf.setImage(with: imageURL)
        self.movie = movie
        self.movieNameLabel.text = movie.title
        self.movieRatingLabel.text! = "Rating: \(movie.rating)/10"
    }
    
}
