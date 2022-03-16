//
//  HomeViewControllerViewModel.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import Foundation

protocol HomeViewControllerViewModelProtocol: AnyObject {
    func didGetMovieData(movieData: [MovieDetails])
    func didGetError(errorMessage: String)
}

class HomeViewControllerViewModel {

    weak var delegate: HomeViewControllerViewModelProtocol?
    
    func getMovieData() {
        APIManager.shared.getResponse(urlString: .TopMovies, forType: MovieData.self) { movieDetails in
            switch movieDetails {
            case .success(let movieDetails) :
                self.delegate?.didGetMovieData(movieData: movieDetails.items)
            case .failure(_):
                self.delegate?.didGetError(errorMessage: Constants.movieFetchingError)
            }
        }
    }
        
}
