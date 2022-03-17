//
//  MovieViewControllerViewModel.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import Foundation

class MovieViewControllerViewModel {
    var reloadTableView: (() -> Void)?
    var movieFetchingError: ((String) -> Void)?
    
    var movieTableCellViewModel = [MovieTableCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var numberOfRows: Int {
        return self.movieTableCellViewModel.count
    }
    
    func getMovieData() {
        APIManager.shared.getResponse(urlString: .TopMovies, forType: MovieData.self) { movieDetails in
            var movieCellModelViewArray = [MovieTableCellModel]()
            switch movieDetails {
            case .success(let movieDetails) :
                for movie in movieDetails.items {
                    movieCellModelViewArray.append(self.createCellModel(movie: movie))
                }
                
                self.movieTableCellViewModel = movieCellModelViewArray
                
            case .failure(let error):
                if let movieFetchingError = self.movieFetchingError {
                    movieFetchingError(error.localizedDescription)
                }
            }
        }
    }
        
    func getMovieCellDataModel(indexPath: IndexPath) -> MovieTableCellModel {
        return movieTableCellViewModel[indexPath.row]
    }
    
    private func createCellModel(movie: MovieDetails) -> MovieTableCellModel {
        return MovieTableCellModel(movieModel: movie)
    }
}
