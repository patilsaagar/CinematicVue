//
//  APIManager.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func getResponse<T: Decodable>(urlString: EndpointURL, forType: T.Type, completion: @escaping ( Result<T, Error>) -> Void) {
        
        guard let urlString = URL(string: urlString.rawValue) else { return }
        
        URLSession.shared.dataTask(with: urlString) { data, httpResponse, error in
            
            if let error = error {
                
                completion(.failure(error))
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(result))
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
