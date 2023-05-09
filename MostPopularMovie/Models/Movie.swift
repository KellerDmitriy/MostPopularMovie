//
//  Movie.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 05.05.2023.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let year: String
    let image: URL
    let imDbRating: String
}

struct MostPopularMovie: Decodable {
    let items: [Movie]
}





