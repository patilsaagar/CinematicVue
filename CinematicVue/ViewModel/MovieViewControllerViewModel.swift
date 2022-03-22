//
//  MovieViewControllerViewModel.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import Foundation

class MovieViewControllerViewModel {

    private lazy var movieResource = MovieResource() // not the best approach but fine for now, maybe we can use some creational patterns for this

    // what's the purpose of this property? can the reload be done in the same function
    var reloadTableView: (() -> Void)?
    var movieFetchingError: ((String) -> Void)? // why explicit error closure?

    // what purpose does this property serve?
    var movieTableCellViewModel = [MovieTableViewCellProtocol]() {
        didSet { reloadTableView?() }
    }

    // what purpose does this property serve?
    var numberOfRows: Int {
        return self.movieTableCellViewModel.count
    }

    var movieCellModelViewArray = [MovieTableViewCellProtocol]()
    
    func getMovieData() {

        movieResource.getMovie(urlString: .TopMovies) { movieResponse in

            // for some reason this is bothering me, i guess this is because its a DTO and I don't like this to be done in the view model
            // QUESTION: this model is now tightly coupled to this function, do we want it to be tightly coupled?
            //var movieCellModelViewArray = [MovieTableViewCellProtocol]()
            switch movieResponse {
            case .success(let movieDetails):
                // extra code inside the case statement is bad
                self.populateMovieCellModelViewArray(movieDetails: movieDetails!)
                self.movieTableCellViewModel = self.movieCellModelViewArray

            case .failure(let error):
                if let movieFetchingError = self.movieFetchingError {
                    movieFetchingError(error.localizedDescription)
                }
            }
        }
    }

    private func populateMovieCellModelViewArray(movieDetails: [MovieDetails]) {
        for movie in movieDetails {
            movieCellModelViewArray.append(self.createCellModel(movie: movie))
        }
    }
        
    func getMovieCellDataModel(indexPath: IndexPath) -> MovieTableViewCellProtocol {
        return movieTableCellViewModel[indexPath.row]
    }
    
    private func createCellModel(movie: MovieDetails) -> MovieTableViewCellProtocol {
        return MovieTableCellModel(movieModel: movie)
    }
}
