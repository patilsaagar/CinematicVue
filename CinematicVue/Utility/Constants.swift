//
//  Constants.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

enum EndpointURL: String {
    case TopMovies = "https://imdb-api.com/en/API/Top250Movies/k_23j0vno9"
}

struct Constants {
    static let homeViewControllerTitle = "Movies"
    static let movieTableViewCellIdentifier = "MovieTableViewCell"
    static let tableviewCellDequeueError = "Error while dequeuing cell"
    static let movieFetchingError = "Error while downloading Movie Details"
}
