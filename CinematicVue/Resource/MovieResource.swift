//
//  MovieResource.swift
//  CinematicVue
//
//  Created by CodeCat15 on 3/21/22.
//

import Foundation

class MovieResource {

    // I am not a big fan of the result type as it creates those switch cases but it's fine

    func getMovie(urlString: EndpointURL, completion: @escaping (Result<[MovieDetails]?, ApiError>) -> Void) {

        var getMovieRequest = URLRequest(url: URL(string: EndpointURL.TopMovies.rawValue)!)
        getMovieRequest.httpMethod = HttpMethod.get.rawValue

        APIManager.shared.getResponse(request: getMovieRequest, forType: MovieData.self) { movieResponse in
            switch movieResponse{
            case .success(let movies):
                completion(.success(movies?.items))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
