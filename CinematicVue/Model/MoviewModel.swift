//
//  MoviewModel.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import Foundation

struct MovieData: Decodable {
    let items: [MovieDetails]
}

struct MovieDetails: Decodable {
    let id: String
    let rank: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
    let imDbRating: String
    let imDbRatingCount: String
}
