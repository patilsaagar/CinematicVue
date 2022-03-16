//
//  MovieTableViewCell.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import UIKit

protocol MovieTableViewCellProtocol {
    var movieIMDBRating: String { get }
    var movieCrew: String { get }
    var movieTitle: String { get }
    var movieImage: String { get }
}

class MovieTableViewCell: UITableViewCell {
        
    @IBOutlet weak var movieIMDBRating: UILabel!
    @IBOutlet weak var movieCrew: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    func configureTableCell(with movieData: MovieTableViewCellProtocol) {
        self.movieIMDBRating.text = movieData.movieIMDBRating
        self.movieTitle.text = movieData.movieTitle
        self.movieCrew.text = movieData.movieCrew
        self.movieImage.downloaded(from: movieData.movieImage)
    }
}
