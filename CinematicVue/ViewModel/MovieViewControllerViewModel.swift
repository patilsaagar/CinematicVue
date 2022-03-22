//
//  MovieViewControllerViewModel.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import Foundation

class MovieViewControllerViewModel {
    
    private let movieResource: MovieResourceFetchable
    // not the best approach but fine for now, maybe we can use some creational patterns for this
    
    init(movieResource: MovieResourceFetchable) {
        self.movieResource = movieResource
    }
    // what's the purpose of this property? can the reload be done in the same function
    var bindDataToViewController: (([MovieDetails], String?) -> Void)? // why explicit error closure?
    
    // what purpose does this property serve?
    var movieTableCellData = [MovieTableViewCellProtocol]()
    
    // what purpose does this property serve?
    var numberOfRowForTableView: Int {
        return self.movieTableCellData.count
    }
    
    
    func getMovieData() {
        
        movieResource.getMovie(urlString: .TopMovies) { movieResponse in
            
            // for some reason this is bothering me, i guess this is because its a DTO and I don't like this to be done in the view model
            // QUESTION: this model is now tightly coupled to this function, do we want it to be tightly coupled?
            //var movieCellModelViewArray = [MovieTableViewCellProtocol]()
            switch movieResponse {
            case .success(let movieDetails):
                // extra code inside the case statement is bad
                guard let bindDataToViewController = self.bindDataToViewController,
                      let movieDetails = movieDetails else { return }
                
                bindDataToViewController(movieDetails, nil)
                
            case .failure(let error):
                guard let bindDataToViewController = self.bindDataToViewController else { return }
                bindDataToViewController([], error.localizedDescription)
            }
        }
    }
    
    func getMovieCellDataModel(indexPath: IndexPath) -> MovieTableViewCellProtocol {
        return movieTableCellData[indexPath.row]
    }
    
    func populateMovieCellModelViewArray(movieDetails: [MovieDetails]) {
        var movieCellModelViewArray = [MovieTableViewCellProtocol]()
        
        for movie in movieDetails {
            movieCellModelViewArray.append(self.createCellModel(movie: movie))
        }
        
        self.movieTableCellData = movieCellModelViewArray
    }
    
    private func createCellModel(movie: MovieDetails) -> MovieTableViewCellProtocol {
        return MovieTableCellModel(movieModel: movie)
    }
}
