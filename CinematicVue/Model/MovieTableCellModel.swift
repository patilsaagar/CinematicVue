//
//  MovieTableCellViewModel.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

protocol MovieTableViewCellProtocol {
    var movieIMDBRating: String { get }
    var movieCrew: String { get }
    var movieTitle: String { get }
    var movieImage: String { get }
}

struct MovieTableCellModel: MovieTableViewCellProtocol {
    var movieImage: String
    var movieIMDBRating: String
    var movieCrew: String
    var movieTitle: String
    
    init(movieModel: MovieDetails) {
        self.movieIMDBRating = movieModel.imDbRating
        self.movieCrew = movieModel.crew
        self.movieTitle = movieModel.title
        self.movieImage = movieModel.image
    }
}
