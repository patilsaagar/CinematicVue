//
//  MovieTableCellViewModel.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

struct MovieTableCellViewModel: MovieTableViewCellProtocol {
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
