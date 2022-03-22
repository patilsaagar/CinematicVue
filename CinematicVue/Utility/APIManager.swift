//
//  APIManager.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import Foundation

enum HttpMethod : String {
    case get
    case post
}


/* reason to have different error types is so that during debugging we know what kind of error message was enountered and at what stage
 doing so makes it easy to pinpoint the reason of failure*/

enum ApiError : Error {
    case serverError
    case jsonDecoder
    case errorHttpStatusCode
    case nilData
    case other
}

final class APIManager {
    static let shared = APIManager()
    private init() {}

    /**
     I have modified the function signature to accept a URLRequest than a URLEndpoint
     */
    func getResponse<T: Decodable>(request: URLRequest, forType: T.Type, completion: @escaping ( Result<T?, ApiError>) -> Void) {

        performDataOperations(request: request, forType: T.self) { apiResponse in
            switch apiResponse {
            case .success(let response):
                completion(.success(response))
            case .failure( let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: Private functions
    /**
     Since this code has the potential to repeat itself for get, post, put and delete operations
     we create a private function where the code will be added just once
     */
    private func performDataOperations<T:Decodable>(request: URLRequest, forType: T.Type, completion: @escaping ( Result<T, ApiError>) -> Void) {

        URLSession.shared.dataTask(with: request) { data, httpResponse, error in

            // if there is a server error then return api error server
            if(error != nil){completion(.failure(ApiError.errorHttpStatusCode))}

            // if the httpstatus code is not in the range of 200 then return error
            if let response = httpResponse as? HTTPURLResponse, !(200 ... 299).contains(response.statusCode) {
                completion(.failure(ApiError.errorHttpStatusCode))
            }

            // if the data received from server is nil then return error
            if(data == nil){completion(.failure(ApiError.nilData))}

            // if the api response has date then in that case we need to set the date decoding strategy but for now this is okay
            do {
                completion(.success(try JSONDecoder().decode(T.self, from: data!)))
            } catch let error {
                debugPrint(error.localizedDescription)
                completion(.failure(ApiError.jsonDecoder))
            }

        }.resume()
    }
}
