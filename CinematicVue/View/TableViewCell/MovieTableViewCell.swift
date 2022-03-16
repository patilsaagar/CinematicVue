//
//  MovieTableViewCell.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import UIKit
import SDWebImage

protocol MovieTableViewCellProtocol {
    var movieIMDBRating: String { get }
    var movieCrew: String { get }
    var movieTitle: String { get }
    var movieImage: String { get }
}

class MovieTableViewCell: UITableViewCell {
        
    @IBOutlet private weak var movieIMDBRating: UILabel!
    @IBOutlet private weak var movieCrew: UILabel!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    
    func configureTableCell(with movieData: MovieTableViewCellProtocol) {
        self.movieIMDBRating.text = movieData.movieIMDBRating
        self.movieTitle.text = movieData.movieTitle
        self.movieCrew.text = movieData.movieCrew
        
        if let movieImageURL = URL(string: movieData.movieImage) {
            self.movieImage.sd_setImage(with: movieImageURL, completed: nil)
        }
    }
}
