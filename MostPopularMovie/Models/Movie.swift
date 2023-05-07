//
//  Movie.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 05.05.2023.
//

import Foundation


struct SearchMovie: Decodable {
    let items: [Movie]
}

struct Movie: Decodable {
    let title: String
    let year: String
    let image: URL
    let imDbRating: String?
}



