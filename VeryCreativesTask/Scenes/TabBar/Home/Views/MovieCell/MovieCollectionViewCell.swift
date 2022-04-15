//
//  MovieCollectionViewCell.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(name: String, movieImageURL: String) {
        guard let imageURL = URL(string: (Constants.imagesBaseURL + movieImageURL)) else { return }
        
        self.movieImage.kf.setImage(with: imageURL)
        self.movieNameLabel.text = name
    }

}
